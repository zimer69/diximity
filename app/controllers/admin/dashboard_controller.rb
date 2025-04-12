class Admin::DashboardController < Admin::BaseController
  def index
    @total_users = User.count
    @total_posts = Post.count
    @total_ads = Ad.count
    @recent_users = User.order(created_at: :desc).limit(5)
    @recent_posts = Post.order(created_at: :desc).limit(5)
    @recent_ads = Ad.order(created_at: :desc).limit(5)
  end
end
