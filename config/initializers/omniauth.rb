Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET
  provider :gplus, GPLUS_KEY, GPLUS_SECRET
  provider :twitter, TWITTER_CONSUMER_KEY, TWITTER_CONSUMER_SECRET
  provider :github, GITHUB_KEY, GITHUB_SECRET
end