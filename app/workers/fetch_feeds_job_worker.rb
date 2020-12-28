class FetchFeedsJobWorker
  require 'nokogiri'
  require 'open-uri'
  include Sidekiq::Worker
  sidekiq_options :retry => false, :queue => "default"

  def perform
    Feed.all.each do |feed|
      next unless feed.rss_path
      rss_path = feed.rss_path
      feed.load_rss_content(rss_path)
    end
  end

end