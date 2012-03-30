# TODO load only Rails are used
class ArticleBackground
  include Rails.application.routes.url_helpers

  def edit_article_path(*args)
    edit_admin_article_path(*args)
  end

  def publish_article(factory)
    FactoryGirl.build(factory).publish
  end
end
