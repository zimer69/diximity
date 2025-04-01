class PostsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy, @posts = pagy(Post.order(published_at: :desc, id: :desc), items: 5)
  end

  def show
    @post = Post.find(params[:id])
  end
end
