class Article
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :feed, :title, :summary, :content, :pubdate

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
