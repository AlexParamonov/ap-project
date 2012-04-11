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
  end
end
