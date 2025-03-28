module ApplicationHelper
    include Pagy::Frontend
    
    def render_load_more(pagy)
        render "shared/load_more", pagy: pagy
    end
end
