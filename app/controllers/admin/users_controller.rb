class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order(created_at: :desc)
    if params[:search].present?
      @users = @users.where("name ILIKE :search OR email ILIKE :search OR specialty ILIKE :search", 
                           search: "%#{params[:search]}%")
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :bio, 
      :specialty, 
      :profile_summary, 
      :profile_picture, 
      :background_image, 
      :is_active,
      address_attributes: [
        :id,
        :address1,
        :address2,
        :city,
        :state,
        :zip,
        :country
      ]
    )
  end
end
