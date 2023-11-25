require 'rails_helper'

RSpec.describe 'GET /api/v1/shows/unseen' do
  context 'without a valid api token' do
    it 'returns with status code 401' do
      get '/api/v1/shows/unseen'

      expect(response.status).to eq 401
      expect(response.body).to be_empty
    end
  end

  context 'with an api token belonging to a known user' do
    let(:user)           { FactoryBot.create :user, :confirmed }
    let(:token)          { FactoryBot.create :oauth_token, resource_owner_id: user.id }

    let(:seen_show)      { FactoryBot.create :show }
    let(:seen_season)    { FactoryBot.create :season, show: seen_show }
    let(:seen_episode)   { FactoryBot.create :episode, season: seen_season }

    let(:unseen_show)    { FactoryBot.create :show }
    let(:unseen_season)  { FactoryBot.create :season, show: unseen_show }
    let(:unseen_episode) { FactoryBot.create :episode, season: unseen_season }

    let(:headers) do
      {
        'Authorization' => "Bearer #{token.token}",
        'Accept'        => 'application/json'
      }
    end

    before do
      FactoryBot.create :subscription, user: user, show: seen_show
      FactoryBot.create :subscription, user: user, show: unseen_show

      FactoryBot.create :episode_state, :seen,   user: user, episode: seen_episode
      FactoryBot.create :episode_state, :unseen, user: user, episode: unseen_episode
    end

    it 'renders the expected json response' do
      get '/api/v1/shows/unseen', headers: headers

      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        data: [
          {
            id: unseen_show.slug,
            type: :shows,
            attributes: {
             title:    unseen_show.title,
             image:    "https://cache.example.com#{unseen_show.image_url}",
             overview: unseen_show.overview,
             rating:   unseen_show.rating,
            }
          }
        ],
        links: {
          first: "http://www.example.com/api/v1/shows/unseen?page%5Bnumber%5D=1&page%5Bsize%5D=10",
          last: "http://www.example.com/api/v1/shows/unseen?page%5Bnumber%5D=1&page%5Bsize%5D=10",
          next: nil,
          prev: nil,
          self: "http://www.example.com/api/v1/shows/unseen?page%5Bnumber%5D=1&page%5Bsize%5D=10"
        }
      }.to_json)
    end
  end
end
