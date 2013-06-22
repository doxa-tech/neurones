class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include Admin::RightsHelper
  include ApplicationHelper

  def default_url_options(options = nil)
    {:format => "html"}
  end
end
