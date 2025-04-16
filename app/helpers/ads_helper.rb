module AdsHelper
  def fetch_ads_for_user
    if current_user&.specialty.present?
      # If user is logged in and has a specialty, show ads matching their specialty
      @ads_left = Ad.where(specialty: current_user.specialty, position: 'left').order("RANDOM()").limit(1)
      @ads_right = Ad.where(specialty: current_user.specialty, position: 'right').order("RANDOM()").limit(1)
    else
      # If no user or no specialty, show random ads
      @ads_left = Ad.where(position: 'left').order("RANDOM()").limit(1)
      @ads_right = Ad.where(position: 'right').order("RANDOM()").limit(1)
    end
  end
end
