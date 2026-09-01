require "rails_helper"

RSpec.describe OidcIdentity, type: :model do
  it "requires each provider issuer uid tuple to be unique" do
    identity = FactoryBot.create(:oidc_identity)
    duplicate = FactoryBot.build(
      :oidc_identity,
      provider: identity.provider,
      issuer: identity.issuer,
      uid: identity.uid
    )

    expect(duplicate).not_to be_valid
  end

  it "allows the same uid for another issuer" do
    identity = FactoryBot.create(:oidc_identity)
    duplicate_uid = FactoryBot.build(
      :oidc_identity,
      provider: identity.provider,
      issuer: "https://other-idp.example.ts.net",
      uid: identity.uid
    )

    expect(duplicate_uid).to be_valid
  end
end
