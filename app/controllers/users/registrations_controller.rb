# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_account_update_params, only: [:update]

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :bio, :specialty, :profile_summary,
      :profile_picture, :background_image,
      address_attributes: [
        :id, :address1, :address2, :city, :state, :zip, :country, :tax_phone_number
      ]
    ])
  end

  # ✅ Skip password requirement if password fields are blank
  def update_resource(resource, params)
    if params[:password].present? || params[:password_confirmation].present?
      super
    else
      resource.update_without_password(account_update_params.except(:current_password))
    end
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
