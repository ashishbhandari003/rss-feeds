class Feed
  include Mongoid::Document

  field :title, type: String
  field :url, type: String
  field :rss_path, type: String

  has_many :posts, dependent: :destroy

  def load_rss_content(rss_path)
    xmlDoc = Nokogiri::XML(open(rss_path))
    rssItemNodes = xmlDoc.root.xpath("channel/item")
    for index in 0..rssItemNodes.length - 1 do
      next if Post.where(url: rssItemNodes[index].at_xpath("link").content).present?
      Post.create(feed: id, title: rssItemNodes[index].at_xpath("title").content, url: rssItemNodes[index].at_xpath("link").content, published_at: Time.parse(rssItemNodes[index].at_xpath("pubDate").content))
    end
  end

end
