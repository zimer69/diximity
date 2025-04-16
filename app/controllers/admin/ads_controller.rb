class Admin::AdsController < Admin::BaseController
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :performance]

  def index
    @ads = Ad.order(created_at: :desc)
    @daily_stats = {}
    
    # Get daily stats for all ads for the last 30 days
    30.downto(0) do |days_ago|
      date = days_ago.days.ago.to_date
      date_str = date.strftime('%Y-%m-%d')
      @daily_stats[date_str] = {}
      
      @ads.each do |ad|
        clicks = ad.ad_clicks.where(clicked_at: date.beginning_of_day..date.end_of_day).count
        @daily_stats[date_str][ad.id] = {
          clicks: clicks,
          title: ad.title,
          position: ad.position
        }
      end
    end
    
    @daily_stats_json = @daily_stats.to_json
  end

  def comparison
    @ads = Ad.all
    @daily_stats = {}
    
    # Get daily stats for all ads for the last 30 days
    30.downto(0) do |days_ago|
      date = days_ago.days.ago.to_date
      date_str = date.strftime('%Y-%m-%d')
      @daily_stats[date_str] = {}
      
      @ads.each do |ad|
        clicks = ad.ad_clicks.where(clicked_at: date.beginning_of_day..date.end_of_day).count
        @daily_stats[date_str][ad.id] = {
          clicks: clicks,
          title: ad.title,
          position: ad.position
        }
      end
    end
    
    @daily_stats_json = @daily_stats.to_json
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
  # Get daily stats for the last 30 days
  @daily_stats = {}
  30.downto(0) do |days_ago|
    date = days_ago.days.ago.to_date
    clicks = @ad.ad_clicks.where(clicked_at: date.beginning_of_day..date.end_of_day).count
    @daily_stats[date.strftime('%Y-%m-%d')] = clicks
  end
  @daily_stats_json = @daily_stats.to_json
end


  private

  def set_ad
    @ad = Ad.find(params[:id])
  end

  def ad_params
    params.require(:ad).permit(:title, :content, :target_url, :specialty, :position, :image_url)
  end
end
