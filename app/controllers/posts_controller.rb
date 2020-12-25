class PostsController < ApplicationController

  def index
    @posts = Post.order_by(published_at: :desc)
  end

  def fetch_feeds
    FetchFeedsJob.perform_later
  end

end
