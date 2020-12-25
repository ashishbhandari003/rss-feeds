class Post
  include Mongoid::Document

  field :title, type: String
  field :url, type: String
  field :published_at, type: Time
  field :is_published, type: Boolean, default: false

  belongs_to :feed

end
