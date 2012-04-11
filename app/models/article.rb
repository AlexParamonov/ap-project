require "virtus"
require_relative "feed"

class Article
  include Virtus
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attribute :feed, Feed

  attribute :title, String
  attribute :summary, String
  attribute :content, String
  attribute :pubdate, DateTime

  validates :title, presence: true

  def initialize(attrs = {})
    attrs.each { |k,v| public_send("#{k}=", v)}
  end

  def publish(clock = DateTime)
    return false unless valid?

    self.pubdate = clock.now
    feed.add_entry(self)
  end

  def persisted?
    false
  end
end
