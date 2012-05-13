require "active_record"

module Persistence
  class Article < ::ActiveRecord::Base
    self.table_name = :articles

    def feed=(new_value)
      # ignore feed
    end

    def feed
      THE_FEED
    end

    def self.most_recent(limit)
      self.order("pubdate DESC").limit(limit)
    end
  end
end
