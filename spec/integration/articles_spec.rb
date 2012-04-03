require_relative "../spec_helper"

describe "Articles behavior:" do
  include I18nSupport

  let(:user) do
    TestUser.new.tap do |user|
      user.action_framework = self
    end
  end

  let(:background) { ArticleBackground.new }
  before(:each) do
    visit '/'
  end

  context "reader at" do
    let(:alice) { user.act_as :ArticleReader }

    describe "article listing page" do
      before(:each) do
        @oor         = background.publish_article :oor_article
        @js          = background.publish_article :js_article
        @unpublished = background.publish_article :unpublished_article

        alice.click 'articles'
      end

      pending "should see published articles" do
        [@oor, @js].each do |article|
          alice.see link: article.title
          alice.see article.summary
        end
      end

      pending "should not see unpublished articles" do
        alice.not_see link: @unpublished.title
        alice.not_see @unpublished.summary
      end

      pending "is able to open article page for reading" do
        alice.click @oor.title
        alice.should_be_at article_path(@oor)
      end
    end

    describe "article view page" do
      before(:each) do
        @oor = background.publish_article :oor_article

        alice.click 'articles'
        alice.click @oor.title
      end

      pending "should see article fields" do
        alice.see @oor.title,
                  @oor.summary,
                  @oor.content
      end
    end
  end

  context "admin at" do
    let(:alex) { user.act_as :ArticleEditor }

    describe "article listing page" do
      before(:each) do
        @oor         = background.publish_article :oor_article
        @unpublished = background.publish_article :unpublished_article

        alex.click 'articles'
      end

      pending "should see published and unpublished articles" do
        [@oor, @unpublished].each do |article|
          alex.see link: article.title
          alex.see article.summary
        end
      end

      pending "is able to open article preview page" do
        alex.click @oor.title
        alex.should_be_at preview_article_path(@oor)
      end

      pending "is able to open article edit page" do
        alex.click @oor.title,
                   'edit' # TODO Click edit near title...
        alex.should_be_at edit_article_path(@oor)
      end

      it "is able to open new article page" do
        alex.click 'new_article'
        alex.should_be_at new_article_path
      end
    end

    describe "article preview page" do
      before(:each) do
        @oor = background.publish_article :oor_article

        alex.click 'articles'
        alex.click @oor.title
      end

      pending "should see article fields" do
        alex.see  @oor.title,
                  @oor.summary,
                  @oor.content
      end

      pending "is able to open article edit page" do
        alex.click 'edit'
        alex.should_be_at edit_article_path
      end
    end

    describe "article new page" do
      before(:each) do
        alex.open_new_article_page
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

        within('entries') do
          see "New article"
              "Article summary"
              "Article content"
        end

      end
    end


    describe "article edit page" do
      before(:each) do
        alex.open_edit_article_page_for @oor
      end

      pending "should see article fields inside input tags" do
        within 'input' do alex.see @oor.title end
        within 'input' do alex.see @oor.summary end
        within 'input' do alex.see @oor.content end
      end

      pending "is able to change title" do
        fill_in "New title for OOR book" => :title
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New title for OOR book"
      end

      pending "is able to change summary" do
        fill_in "New summary for OOR book" => :summary
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New summary for OOR book"
      end

      pending "is able to change content" do
        fill_in "New content for OOR book" => :content
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New content for OOR book"
      end

      pending "is able to open article preview page" do
        alex.click 'preview'
        alex.should_be_at preview_article_path(@oor)
      end

      pending "is able to remove article" do
        alex.click 'remove',
                   'Confirm'

        alex.see 'article_removed'
        alex.should_be_at articles_path
      end
    end
  end
end
