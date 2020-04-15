Doorkeeper.configure do
  orm :active_record

  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  resource_owner_from_credentials do |routes|
    # Since we are using Basic Authorizaion we parse the Authorization header
    # and check if the credentials are valid by fetching the application
    # matching those credentials
    authorization = request.authorization
    if authorization.present? && authorization =~ /^Basic (.*)/m
      credentials = Base64.decode64(Regexp.last_match[1]).split(/:/, 2)
      uid         = credentials.first
      secret      = credentials.second
      application = Doorkeeper::Application.by_uid_and_secret uid, secret
    end
    # Use Devise's find_for_database_authentication method in User model.
    user = User.find_for_database_authentication(email: params[:username])
    # Only accept if we have a valid application, user and valid credentials
    user if application && user && (user.valid_password? params[:password])
  end

  default_scopes :read, :write

  enforce_configured_scopes

  client_credentials :from_basic

  grant_flows %w[password]
end
