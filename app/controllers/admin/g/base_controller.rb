class Admin::G::BaseController < ApplicationController
  layout 'group/admin'

  # control the ownerships
  before_filter :load_and_authorize_group
end
