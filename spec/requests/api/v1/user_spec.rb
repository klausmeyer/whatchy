require 'rails_helper'

RSpec.describe 'GET /api/v1/user' do
  context 'without a valid api token' do
    it 'returns with status code 401' do
      get '/api/v1/user'

      expect(response.status).to eq 401
      expect(response.body).to be_empty
    end
  end

  context 'with an api token belonging to a known user' do
    let(:user) { FactoryBot.create :user, :confirmed }
    let(:token) { FactoryBot.create :oauth_token, resource_owner_id: user.id }

    let(:headers) do
      {
        'Authorization' => "Bearer #{token.token}",
        'Accept' => 'application/json'
      }
    end

    it 'renders the expected json response' do
      get '/api/v1/user', headers: headers

      expect(response.status).to eq 200
      expect(response.body).to be_json_eql({
        data: {
          id: user.email,
          type: :users,
          attributes: {
            email: user.email
          }
        }
      }.to_json)
    end
  end
end
