class PostsController < ApplicationController

  def index
    @posts = Post.order_by(published_at: :desc)
  end

  def fetch_feeds
  	FetchFeedsJobWorker.perform_async #calling sidekiq worker
    #FetchFeedsJob.perform_later #calling active job
  end

end
