class ExploreController < ApplicationController
  def index
    if current_user.nil?
      @users = User.all 
    else
      @users = User.where.not(id: current_user.id).includes(:address)
    end

    @users = @users.where("users.name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where("users.specialty ILIKE ?", "%#{params[:specialty]}%") if params[:specialty].present?
    @users = @users.joins(:address).where("addresses.city ILIKE ?", "%#{params[:location]}%") if params[:location].present?
  end
end
