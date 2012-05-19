require "virtus"

class Feed
  include Virtus

  attr_writer :article_source

  def initialize
    @entries = []
  end

  def initialize(entry_fetcher=->{Article::Mapper.most_recent})
    @entry_fetcher = entry_fetcher
  end

  def new_article(*attrs)
    article_source.call(*attrs).tap do |article|
      article.feed = self
    end
  end

  def add_entry(entry)
    entry.load_attributes_to_persistence
  end

  def title
    "Articles"
  end

  def entries
    fetch_entries.to_a
  end

  def article(article_id)
    fetch_entries.fetch(article_id.to_i)
  end

  private
  def article_source
    @article_source ||= Article.public_method(:new)
  end

  def fetch_entries
    @entry_fetcher.()
  end
end
