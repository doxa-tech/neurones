class G::BaseController < ApplicationController
	layout 'group/application'
	include G::BaseHelper
  include G::EventsHelper
end
