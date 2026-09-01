namespace :oidc do
  desc "Link an existing Whatchy user to an OIDC subject"
  task link: :environment do
    user_email = ENV.fetch("USER_EMAIL")
    uid = ENV.fetch("OIDC_UID")
    issuer = ENV.fetch("OIDC_ISSUER")
    provider = ENV.fetch("OIDC_PROVIDER", "openid_connect")
    oidc_email = ENV["OIDC_EMAIL"]

    user = User.find_by!(email: user_email)
    identity = user.oidc_identities.find_or_initialize_by(provider: provider, issuer: issuer)
    identity.uid = uid
    identity.email = oidc_email
    identity.claims = identity.claims.merge("sub" => uid)
    identity.save!

    puts "Linked #{user.email} to #{provider} subject #{uid} from #{issuer}"
  end
end
