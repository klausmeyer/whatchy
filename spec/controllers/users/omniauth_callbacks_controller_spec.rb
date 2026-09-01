require "rails_helper"

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
    request.env["omniauth.auth"] = auth_hash
  end

  let(:issuer) { "https://idp.example.ts.net" }
  let(:auth_hash) do
    OmniAuth::AuthHash.new(
      provider: "openid_connect",
      uid: "oidc-user-1",
      info: {
        email: "oidc-user@example.com",
        name: "OIDC User",
        image: "https://example.com/avatar.png"
      },
      extra: {
        id_info: {
          issuer: issuer,
          raw_attributes: {
            "sub" => "oidc-user-1",
            "email" => "oidc-user@example.com"
          }
        }
      }
    )
  end

  describe "GET #openid_connect" do
    it "signs in a linked user" do
      identity = FactoryBot.create(:oidc_identity, user: FactoryBot.create(:user, :confirmed), issuer: issuer, uid: "oidc-user-1")

      get :openid_connect

      expect(controller.current_user).to eq(identity.user)
      expect(response).to redirect_to(root_path)
    end

    it "refreshes profile details from the OIDC claims" do
      identity = FactoryBot.create(:oidc_identity, user: FactoryBot.create(:user, :confirmed), issuer: issuer, uid: "oidc-user-1")

      get :openid_connect

      identity.reload
      expect(identity.email).to eq("oidc-user@example.com")
      expect(identity.name).to eq("OIDC User")
      expect(identity.picture).to eq("https://example.com/avatar.png")
      expect(identity.claims).to include("sub" => "oidc-user-1")
    end

    it "rejects an unlinked OIDC identity" do
      get :openid_connect

      expect(controller.current_user).to be_nil
      expect(response).to redirect_to(new_user_session_path)
      expect(flash[:alert]).to eq("Your OIDC account is not linked to a Whatchy user.")
    end
  end
end
