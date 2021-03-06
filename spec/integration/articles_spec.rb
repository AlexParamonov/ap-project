require_relative "../spec_helper"
require_relative "../support/test_user"
require_relative "../support/article_background"

describe "Articles behavior:" do
  include I18nSupport
  include SpecHelpers

  let(:user) do
    TestUser.new.tap do |user|
      user.action_framework = self
    end
  end

  let(:background) do
    ArticleBackground.new.tap do |article_background|
      article_background.action_framework = self
    end
  end

  context "reader at" do
    let!(:reader) { user.act_as :ArticleReader }

    describe "article listing page" do
      before(:each) do
        @oor         = background.publish_article :oor_article
        @js          = background.publish_article :js_article
        @unpublished = background.publish_article :unpublished_article

        reader.visit_articles_listing
      end

      it "should see published articles" do
        [@oor, @js].each do |article|
          see link: article.title
          see article.summary
        end
      end

      pending "should not see unpublished articles" do
        not_see link: @unpublished.title
        not_see @unpublished.summary
      end

      it "is able to open article page for reading" do
        click @oor.title

        see @oor.title
        not_see @js.title
        # reader.should_be_at article_path(@oor)
      end
    end

    describe "article view page" do
      before(:each) do
        @oor = background.publish_article :oor_article

        reader.visit_articles_listing
        click @oor.title
      end

      it "should see article fields" do
        see @oor.title,
            @oor.content
      end
    end
  end

  context "admin at" do
    let!(:admin) { user.act_as :ArticleAdmin }

    describe "article listing page" do
      before(:each) do
        @oor         = background.publish_article :oor_article
        @js          = background.publish_article :js_article
        @unpublished = background.publish_article :unpublished_article

        admin.visit_articles_listing
      end

      it "should see published and unpublished articles" do
        [@oor, @unpublished].each do |article|
          see link: article.title
          see article.summary
        end
      end

      it "is able to open article preview page" do
        click @oor.title
        see @oor.title
        not_see @js.title
        # admin.should_be_at preview_article_path(@oor)
      end

      pending "is able to open article edit page" do
        click @oor.title,
             'edit' # TODO Click edit near title...
        admin.should_be_at edit_article_path(@oor)
      end

      it "is able to open new article page" do
        click 'new_article'
        admin.should_be_at new_article_path
      end
    end

    describe "article preview page" do
      before(:each) do
        @oor = background.publish_article :oor_article

        admin.visit_articles_listing
        click @oor.title
      end

      pending "should see article fields" do
        see @oor.title,
            @oor.summary,
            @oor.content
      end

      pending "is able to open article edit page" do
        click 'edit'
        admin.should_be_at edit_article_path
      end
    end

    describe "article new page" do
      before(:each) do
        admin.visit_new_article_page
      end

      it "should see article fields inside input tags" do
        see fields: [
              'article[title]',
              'article[summary]',
              'article[content]'
            ]
      end

      it "is able to publish article" do
        fill_in "New article"     => 'article_title',
                "Article summary" => 'article_summary',
                "Article content" => 'article_content'

        # click 'article.buttons.publish'
        iclick "article.buttons.publish"
        isee   "article.messages.added"

        within('.entries') do
          see "New article"
              "Article summary"
              "Article content"
        end

      end

      it "should not publish article without a title" do
        fill_in "Article summary" => 'article_summary',
                "Article content" => 'article_content'

        iclick "article.buttons.publish"

        within('#error_explanation').isee 'errors.messages.not_saved'

        see fields: [ 'article_title',
                      'article_summary',
                      'article_content', ]

      end

    end


    describe "article edit page" do
      before(:each) do
        admin.visit_edit_article_page_for @oor
      end

      pending "should see article fields inside input tags" do
        within('input').see @oor.title
        within('input').see @oor.summary
        within('input').see @oor.content
      end

      pending "is able to change title" do
        fill_in "New title for OOR book" => :title
        click 'save'
        see 'updated successfully'

        admin.visit_article_listing
        see "New title for OOR book"
      end

      pending "is able to change summary" do
        fill_in "New summary for OOR book" => :summary
        click 'save'
        see 'updated successfully'

        admin.visit_article_listing
        see "New summary for OOR book"
      end

      pending "is able to change content" do
        fill_in "New content for OOR book" => :content
        click 'save'
        see 'updated successfully'

        admin.visit_article_listing
        see "New content for OOR book"
      end

      pending "is able to open article preview page" do
        click 'preview'
        admin.should_be_at preview_article_path(@oor)
      end

      pending "is able to remove article" do
        click 'remove',
              'Confirm'

        see 'article_removed'
        admin.should_be_at articles_path
      end
    end
  end

end
