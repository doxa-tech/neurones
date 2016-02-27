class ApplicationController < ActionController::Base
  include ExceptionsHandler

  protect_from_forgery
  include ArticlesHelper
  include ApplicationHelper
  include GroupsHelper

  def load_and_authorize_group
    @group = Group.find_by_url(params[:group_id] || params[:id])
    load_and_authorize!(controller: "admin/groups", action: "update", resource: @group)
  end
end
