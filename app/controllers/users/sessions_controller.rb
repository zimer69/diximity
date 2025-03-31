# app/controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name, :bio, :specialty, :profile_picture,
      address_attributes: [
        :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :bio, :specialty, :profile_picture,
      address_attributes: [
        :id, :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    ])
  end

  def after_sign_up_path_for(resource)
    user_path(resource)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
