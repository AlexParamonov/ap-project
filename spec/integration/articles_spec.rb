require_relative "../spec_helper"

describe "Articles behavior:" do
  let(:user) do
    TestUser.new.tap do |user|
      user.action_framework = self
    end
  end

  let(:background) { ArticleBackground.new }

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
          alice.see article.sumary
        end
      end

      pending "should not see unpublished articles" do
        alice.not_see link: @unpublished.title
        alice.not_see @unpublished.sumary
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
                  @oor.sumary,
                  @oor.content
      end
    end
  end

  context "admin at" do
    let(:alex) { user.act_as :ArticleEditor }

    describe "article listing page" do
      before(:each) do
        @oor       = background.publish_article :oor_article
        @unpublished = background.publish_article :unpublished_article

        alex.click 'articles'
      end

      pending "should see published and unpublished articles" do
        [@oor, @unpublished].each do |article|
          alex.see link: article.title
          alex.see article.sumary
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

      pending "is able to open new article page" do
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
                  @oor.sumary,
                  @oor.content
      end

      pending "is able to open article edit page" do
        alex.click 'edit'
        alex.should_be_at edit_article_path
      end
    end

    describe "article edit page" do
      pending "should see article fields inside input tags" do
        within 'input' do alex.see @oor.title end
        within 'input' do alex.see @oor.sumary end
        within 'input' do alex.see @oor.content end
      end

      pending "is able to change title" do
        alex.open_edit_article_page_for @oor

        fill_in "New title for OOR book" => :title
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New title for OOR book"
      end

      pending "is able to change summary" do
        alex.open_edit_article_page_for @oor

        fill_in "New summary for OOR book" => :summary
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New summary for OOR book"
      end

      pending "is able to change content" do
        alex.open_edit_article_page_for @oor

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
