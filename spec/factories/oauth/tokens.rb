FactoryBot.define do
  factory :oauth_token, class: 'Doorkeeper::AccessToken' do
    resource_owner_id { FactoryBot.create(:user).id }
    association :application, factory: :oauth_application
    scopes { %w[read write] }
  end
end
