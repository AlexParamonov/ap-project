
class Article
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  attr_accessor :feed, :title, :summary, :content

  def initialize(attrs = {})
    attrs.each { |k,v| public_send("#{k}=", v)}
  end

  def publish
    feed.add_entry(self)
  end

  def persisted?
    false
  end
end
