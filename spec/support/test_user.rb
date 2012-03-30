# TODO load only Rails are used
class TestUser
  include Rails.application.routes.url_helpers

  attr_accessor :action_framework
  def method_missing(meth, *args, &blk)
    action_framework.send meth, *args, &blk
  end

  def respond_to?(*args)
    super || actions.respond_to?(*args)
  end

  def should_be_at(path)
    current_path.should == path
  end

  module ArticleReader
    def open_articles_listing
      visit articles_path
    end
  end

  module ArticleEditor
    def open_edit_article_page_for(article)
      visit edit_admin_article_path(article)
    end

    def open_articles_listing
      visit admin_articles_path
    end
  end
  def act_as(role)
    self.extend class_eval(role.to_s)
  end
end
