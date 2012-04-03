class Feed
  attr_reader :entries
  attr_writer :article_source

  def initialize
    @entries = []
  end

  def new_article(*attrs)
    article_source.call(*attrs).tap do |article|
      article.feed = self
    end
  end

  def add_entry(entry)
    entries << entry
  end

  def title
    "Articles"
  end

  private
  def article_source
    @article_source ||= Article.public_method(:new)
  end
end