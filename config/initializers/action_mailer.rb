if ENV['SMTP_ENABLED'].in? %w(true 1 yes)
  ActionMailer::Base.smtp_settings = {
    user_name:            ENV['SMTP_USERNAME'],
    password:             ENV['SMTP_PASSWORD'],
    domain:               ENV['DOMAIN'],
    address:              ENV['SMTP_SERVER'],
    port:                 (ENV['SMTP_PORT'] || '587').to_i,
    authentication:       :plain,
    enable_starttls_auto: true
  }
end
