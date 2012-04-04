require "ostruct"
require_relative 'action_framework'
require_relative 'test_user'

# TODO load only Rails are used
class ArticleBackground
  include Rails.application.routes.url_helpers
  include ActionFramework

  def admin
    @admin ||= 
      TestUser.new.tap do |user|
        user.action_framework = action_framework
      end.extend TestUser::ArticleEditor
  end

  def edit_article_path(*args)
    edit_admin_article_path(*args)
  end

  def publish_article(factory)
    admin.open_new_article_page

    article = OpenStruct.new FactoryGirl.attributes_for(factory)
    admin.fill_in article.title   => 'article_title',
                  article.summary => 'article_summary',
                  article.content => 'article_content'

    admin.iclick "article.buttons.publish"

    article
  end
end
