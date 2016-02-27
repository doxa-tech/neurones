Rollbar.configure do |config|

  config.access_token = Rails.application.secrets.rollbar_key

  if Rails.env.test? || Rails.env.development?
    config.enabled = false
  end

  config.scrub_fields |= [:remember_token]

  config.person_username_method = "name"

end
