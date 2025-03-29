class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pagy::Backend
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :name, :bio, :specialty, :profile_picture, :profile_summary,
      address_attributes: [
        :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    ])

    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, :bio, :specialty, :profile_picture, :profile_summary,
      address_attributes: [
        :address1, :address2, :city, :state, :zip, :country,
        :tax_phone_number, :latitude, :longitude
      ]
    ])
  end

  def after_sign_in_path_for(resource)
    root_path # or dashboard_path, etc.
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path # or new_user_session_path
  end
end
