require_relative 'exhibit'

class FeedExhibit < Exhibit
  def self.applicable_to?(object)
    object_is_any_of?(object, 'Feed')
  end

  exhibit_query :entries
end
