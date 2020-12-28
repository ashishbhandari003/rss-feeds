class FeedsController < ApplicationController

  def new
  @feed = Feed.new  
  end

  def create
    title = params[:title]
    url = params[:url]
    url = url.include?('http') ? url : 'http://'+url
    doc = Nokogiri::HTML(open(url)) rescue false
    raise 'Invalid Link' unless doc
    rss_path = doc.xpath("//link[@type=\"application/rss+xml\"]").first['href'] rescue false
    raise 'Invalid RSS' unless rss_path
    Feed.create(title: title, url: url, rss_path: rss_path)
    redirect_to root_url
  end

  def index
    @feeds = Feed.all
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    Feed.find(params[:id]).update(params.require(:feed).permit(:title))
    redirect_to feeds_path
  end

  def destroy
    Feed.find(params[:id]).destroy
    redirect_to feeds_path
  end

end
