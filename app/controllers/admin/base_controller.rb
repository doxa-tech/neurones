class Admin::BaseController < ApplicationController
	before_filter :signed_in_admin
	layout 'admin'
end
