class FetchFeedsJob < ApplicationJob
  queue_as :default
  require 'nokogiri'
  require 'open-uri'

  def perform(*args)
    Feed.all.each do |feed|
      next unless feed.rss_path
      rss_path = feed.rss_path
      feed.load_rss_content(rss_path)
    end
  end
end
