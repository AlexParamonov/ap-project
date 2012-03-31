class Feed
  attr_reader :entries
  attr_writer :article_source

  def initialize
    @entries = []
  end

  def new_article
    article_source.call.tap do |article|
      article.feed = self
    end
  end

  def title
    "Articles"
  end

  private
  def article_source
    @article_source ||= Article.public_method(:new)
  end
end
