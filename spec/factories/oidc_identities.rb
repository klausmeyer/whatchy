FactoryBot.define do
  factory :oidc_identity do
    association :user
    provider { "openid_connect" }
    issuer { "https://idp.example.ts.net" }
    sequence(:uid) { |n| "oidc-user-#{n}" }
    sequence(:email) { |n| "oidc-user-#{n}@example.com" }
    name { "OIDC User" }
    picture { "https://example.com/avatar.png" }
    claims { { "sub" => uid, "email" => email } }
  end
end
