class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin_user!
end 