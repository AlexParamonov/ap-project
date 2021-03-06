require "virtus"
require "aequitas"
require_relative "feed"
require "dm_dummy"
require "persistence_mapper"
require "general_mapper"
require_relative '../persistence/article'

class Article
  LIMIT_DEFAULT = 15

  include Virtus
  include Aequitas
  include DMDummy

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  attribute :feed, Feed

  attribute :id, Integer
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

  include PersistenceMapper
  class Mapper < GeneralMapper
    self.model = Article
    self.persistence = ::Persistence::Article
    self.model_methods << :find


    def self.most_recent(limit=LIMIT_DEFAULT)
      new(self.persistence.most_recent(limit))
    end
  end
end
