require 'rails_helper'

RSpec.describe 'GET /api/v1/shows/subscriptions' do
  context 'without a valid api token' do
    it 'returns with status code 401' do
      get '/api/v1/shows/subscriptions'

      expect(response.status).to eq 401
      expect(response.body).to be_empty
    end
  end

  context 'with an api token belonging to a known user' do
    let(:user)  { FactoryBot.create :user, :confirmed }
    let(:token) { FactoryBot.create :oauth_token, resource_owner_id: user.id }
    let(:show)  { FactoryBot.create :show }

    let(:headers) do
      {
        'Authorization' => "Bearer #{token.token}",
        'Accept'        => 'application/json'
      }
    end

    before do
      FactoryBot.create :subscription, user: user, show: show
    end

    it 'renders the expected json response' do
      get '/api/v1/shows/subscriptions', headers: headers

      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        data: [
          {
            id: show.slug,
            type: :shows,
            attributes: {
             title:    show.title,
             image:    "https://cache.example.com#{show.image_url}",
             overview: show.overview,
             rating:   show.rating,
            }
          }
        ],
        links: {
          first: "http://www.example.com/api/v1/shows/subscriptions?page%5Bnumber%5D=1&page%5Bsize%5D=10",
          last: "http://www.example.com/api/v1/shows/subscriptions?page%5Bnumber%5D=1&page%5Bsize%5D=10",
          next: nil,
          prev: nil,
          self: "http://www.example.com/api/v1/shows/subscriptions?page%5Bnumber%5D=1&page%5Bsize%5D=10"
        }
      }.to_json)
    end
  end
end
