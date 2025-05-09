class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :find_user, only: [:show, :update]

  def show
    @user = User.find(params[:id])
    @available_slots = @user.calendar&.time_slots&.available&.upcoming || []
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name,
      :bio,
      :specialty,
      :profile_picture,
      :background_image,
      :profile_summary,
      address_attributes: [
        :id, :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    )
  end
end
