module AdsHelper
  def fetch_ads_for_user
    @ads_left = Ad.where(specialty: current_user.specialty, position: 'left').order("RANDOM()").limit(1)
    @ads_right = Ad.where(specialty: current_user.specialty, position: 'right').order("RANDOM()").limit(1)
  end
end
