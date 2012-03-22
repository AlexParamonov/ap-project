require "bbq/test_user"

class TestUser < Bbq::TestUser
  module ArticleReader
    def open_articles_listing
      visit support.articles_path
    end
  end
  module ArticleManager
    def add_article(params = {})
      open_tickets_listing
      follow "new_article"
      params.each do |param, value|
        fill_in  param, :with => value
      end
      press "create_article"
    end

    def open_articles_listing
      visit support.admin_articles_path
    end
  end
end
