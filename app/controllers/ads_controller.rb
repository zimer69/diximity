class AdsController < ApplicationController
  before_action :authenticate_user!, except: [:track_click]
  skip_before_action :verify_authenticity_token, only: [:track_click]

   def create
    @ad = Ad.new(ad_params)

    if @ad.save
      redirect_to ads_path, notice: 'Ad created successfully.'
    else
      # If there's an error (e.g., missing Open Graph data), show an error message
      flash[:alert] = "Ad creation failed: #{@ad.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def track_click
    @ad = Ad.find(params[:id])

    page = params[:page]
    if current_user
      user_id = current_user.id
    else
      user_id = params[:user_id]
    end

    @ad.track_click(user_id, page)

    head :ok
  end

    private

  def ad_params
    params.require(:ad).permit(:specialty, :target_url, :position)
  end
end