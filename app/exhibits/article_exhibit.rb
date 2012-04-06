require_relative 'exhibit'

class ArticleExhibit < Exhibit
  def self.applicable_to?(object)
    object_is_any_of?(object, 'Article')
  end

  def to_partial_path
    "/articles/article"
  end
end
