class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def passthru
    redirect_to new_user_session_path, alert: "OIDC sign-in is not configured."
  end

  def openid_connect
    identity = OidcIdentity.find_by(
      provider: auth.provider,
      issuer: oidc_issuer,
      uid: auth.uid
    )

    unless identity
      Rails.logger.warn(
        "Unlinked OIDC login provider=#{auth.provider.inspect} issuer=#{oidc_issuer.inspect} uid=#{auth.uid.inspect} email=#{auth.info.email.inspect}"
      )
      redirect_to new_user_session_path, alert: "Your OIDC account is not linked to a Whatchy user."
      return
    end

    refresh_identity(identity)
    sign_in_and_redirect identity.user, event: :authentication
  end

  def failure
    redirect_to new_user_session_path, alert: "Could not authenticate with OIDC."
  end

  private

  def auth
    request.env.fetch("omniauth.auth")
  end

  def oidc_issuer
    id_info_value(:issuer) || id_info_value(:iss) || ENV.fetch("OIDC_ISSUER")
  end

  def refresh_identity(identity)
    identity.update!(
      email: auth.info.email,
      name: auth.info.name,
      picture: auth.info.image,
      claims: oidc_claims
    )
  end

  def oidc_claims
    id_info = auth.extra&.id_info

    if id_info.respond_to?(:raw_attributes)
      id_info.raw_attributes
    elsif id_info.respond_to?(:to_h)
      id_info.to_h
    else
      {}
    end
  end

  def id_info_value(key)
    id_info = auth.extra&.id_info

    if id_info.respond_to?(key)
      id_info.public_send(key)
    elsif id_info.respond_to?(:[])
      id_info[key.to_s] || id_info[key.to_sym]
    end
  end
end
