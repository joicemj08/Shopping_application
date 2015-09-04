#
# Dashboard Controller -
#
# @author [Joice]
#
class DashboardController < ApplicationController
  before_action :authenticate_user!
  # GET  /dashboard
  def index
  end
end
