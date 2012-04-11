require "virtus"
require "aequitas"
require_relative "feed"
require "dm_dummy"

class Article
  include Virtus
  include Aequitas
  include DMDummy

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attribute :feed, Feed

  attribute :title, String
  attribute :summary, String
  attribute :content, String
  attribute :pubdate, DateTime

  validates_presence_of :title

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
