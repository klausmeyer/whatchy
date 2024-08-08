FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name         { 'Factory App' }
    uid          { SecureRandom.hex(8) }
    secret       { SecureRandom.hex(16) }
    scopes       { %w[read write] }
    redirect_uri { 'https://example.com' }
  end
end
