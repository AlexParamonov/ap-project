require "bbq/test_user"

class TestUser < Bbq::TestUser
  module ArticleReader
    def open_articles_listing
      visit support.articles_path
    end
  end
  module ArticleManager
    def add_article(params = {})
      Article.new(params).publish
    end

    def open_articles_listing
      visit support.admin_articles_path
    end
  end
end
