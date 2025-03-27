class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name, :bio, :specialty,
      address_attributes: [
        :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :bio, :specialty,
      address_attributes: [
        :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    ])
  end
end
