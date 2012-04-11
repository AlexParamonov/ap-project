module Persistence
  class Article < ActiveRecord::Base
    set_table_name :articles
  end
end
