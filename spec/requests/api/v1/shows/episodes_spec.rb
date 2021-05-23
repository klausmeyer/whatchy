require 'rails_helper'

RSpec.describe 'GET /api/v1/shows/:slug/episodes' do
  let(:show) { FactoryBot.create :show }

  context 'without a valid api token' do
    it 'returns with status code 401' do
      get "/api/v1/shows/#{show.slug}/episodes"

      expect(response.status).to eq 401
      expect(response.body).to be_empty
    end
  end

  context 'with an api token belonging to a known user' do
    let(:user)  { FactoryBot.create :user, :confirmed }
    let(:token) { FactoryBot.create :oauth_token, resource_owner_id: user.id }

    let(:season1)   { FactoryBot.create :season, show: show }
    let(:season2)   { FactoryBot.create :season, show: show }
    let!(:episode1) { FactoryBot.create :episode, season: season1 }
    let!(:episode2) { FactoryBot.create :episode, season: season2 }

    let!(:episode_state1) { FactoryBot.create :episode_state, :seen, user: user, episode: episode1 }

    let(:headers) do
      {
        'Authorization' => "Bearer #{token.token}",
        'Accept'        => 'application/json'
      }
    end

    it 'renders the expected json response' do
      get "/api/v1/shows/#{show.slug}/episodes", headers: headers

      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        id: episode1.id.to_s,
        type: 'episodes',
        attributes: {
          season: season1.number,
          number: episode1.number,
          title: episode1.title,
          'seen-at': episode_state1.seen_at.utc.iso8601(3)
        }
      }.to_json).at_path('data/0')
    end
  end
end
