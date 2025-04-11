module ApplicationHelper
    include Pagy::Frontend
    
    def render_load_more(pagy)
        render "shared/load_more", pagy: pagy
    end

    def fetch_ads_for_user
        # Get ads for the current user's specialty if they have one
        specialty = current_user&.specialty
        
        # Fetch left and right ads
        @ads_left = Ad.where(position: 'left')
        @ads_right = Ad.where(position: 'right')
        
        # If user has a specialty, filter ads by specialty
        if specialty.present?
            @ads_left = @ads_left.where(specialty: specialty)
            @ads_right = @ads_right.where(specialty: specialty)
        end
        
        # If no specialty-specific ads found, show general ads
        if @ads_left.empty?
            @ads_left = Ad.where(position: 'left', specialty: nil)
        end
        
        if @ads_right.empty?
            @ads_right = Ad.where(position: 'right', specialty: nil)
        end
    end
end
