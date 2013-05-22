Neurones::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  #Perso, for omniauth.rb (Noémien 21 mai 2013)
  FACEBOOK_KEY = '508957672503220'
  FACEBOOK_SECRET = 'e60e41fdec1bfd0d5f267e46a80652bf'

  GPLUS_KEY = '252311055707.apps.googleusercontent.com'
  GPLUS_SECRET = 'n9mEkuuKsZGylyzRmclCgp8p'

  TWITTER_CONSUMER_KEY = '0vQvci0j0JtF0UKVfvIJkQ'
  TWITTER_CONSUMER_SECRET = '6Hsd2PYTWeSyi8Zb5gbIr7kC7yKenPtrNymbVJbY2vA'

  GITHUB_KEY = '38798029453b4f7d0129'
  GITHUB_SECRET = '3b5869a1c9ff6edd1e8786b5830430bede44bfeb'
end
