class ExploreController < ApplicationController
  def index
    @users = User.includes(:address)

    # Search filters
    @users = @users.where("users.name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where("users.specialty ILIKE ?", "%#{params[:specialty]}%") if params[:specialty].present?
    @users = @users.joins(:address).where("addresses.city ILIKE ?", "%#{params[:location]}%") if params[:location].present?
  end
end
