class Admin::G::BaseController < ApplicationController
  layout 'group/admin'

  # control the ownerships
  before_filter :group_ownerships
  before_filter {|controller| controller.modify_right(Group)}
end
