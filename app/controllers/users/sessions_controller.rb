class Users::SessionsController < Devise::SessionsController
  def new
    @oidc_configured = Devise.omniauth_configs.key?(:openid_connect)
    @oidc_provider_name = ENV.fetch("OIDC_PROVIDER_NAME", "OIDC")
    super
  end
end
