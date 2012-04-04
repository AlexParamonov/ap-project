class Article
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attr_accessor :feed, :title, :summary, :content, :pubdate

  def initialize(attrs = {})
    attrs.each { |k,v| public_send("#{k}=", v)}
  end

  def publish(clock = DateTime)
    self.pubdate = clock.now
    feed.add_entry(self)
  end

  def persisted?
    false
  end
end
