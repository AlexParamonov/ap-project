require_relative 'action_framework'

# TODO load only Rails are used
class TestUser
  include Rails.application.routes.url_helpers
  include ActionFramework

  def act_as(role)
    self.extend class_eval(role.to_s)
  end

  def should_be_at(path)
    current_path.should == path
  end

  def visit_root
    visit '/'
  end

  module ArticleReader
    def visit_articles_listing
      visit_root
      click 'articles'
    end
  end

  module ArticleEditor
    def visit_edit_article_page_for(article)
      visit edit_admin_article_path(article)
    end

    def visit_new_article_page
      visit new_article_path
    end

    def visit_articles_listing
      visit_root
      click 'articles'
    end
  end

  module ArticleAdmin
    include ArticleReader
    include ArticleEditor
  end
end
