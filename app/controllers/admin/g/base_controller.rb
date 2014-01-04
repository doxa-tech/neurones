class Admin::G::BaseController < ApplicationController
  layout 'group/admin'

  # control the ownerships
  before_filter :group_ownerships
  before_filter {|controller| controller.group_modify_right}
end
