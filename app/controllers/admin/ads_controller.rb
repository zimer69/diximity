class Admin::AdsController < Admin::BaseController
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :performance]

  def index
    @ads = Ad.order(created_at: :desc)
  end

  def show
  end

  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(ad_params)
    if @ad.save
      redirect_to admin_ad_path(@ad), notice: 'Ad was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @ad.update(ad_params)
      redirect_to admin_ad_path(@ad), notice: 'Ad was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @ad.destroy
    redirect_to admin_ads_path, notice: 'Ad was successfully deleted.'
  end

  def performance
    # Get total clicks and impressions
    @clicks = @ad.clicks

    # Get daily stats for the last 30 days
    @daily_stats = {}
    30.downto(0) do |days_ago|
      date = days_ago.days.ago.to_date
      clicks = @ad.clicks.where(created_at: date.beginning_of_day..date.end_of_day).count
      @daily_stats[date.strftime('%Y-%m-%d')] = clicks
    end
  end

  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:title, :content, :budget, :status, :advertiser_id)
  end
end
