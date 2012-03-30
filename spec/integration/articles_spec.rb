require_relative "../spec_helper"

describe "Articles" do
  let(:user) do
    TestUser.new.tap do |user|
      user.action_framework = self
    end
  end

  let(:background) { ArticleBackground.new }

  context "reader at" do
    let(:alice) { user.act_as :ArticleReader }

    context "article listing" do
      before(:each) do
        @oor = background.publish_article :oor_article
        @js  = background.publish_article :js_article

        alice.click 'articles'
      end

      it "should see existing articles" do
        [@oor, @js].each do |article|
          alice.see link: article.title
          alice.see article.sumary
        end
      end

      it "able to open article page" do
        alice.click @oor.title

        alice.see @oor.title,
                  @oor.sumary,
                  @oor.content
      end
    end
  end

  context "admin at" do
    let(:alex) { user.act_as :ArticleEditor }

    context "article listing" do
      before(:each) do
        @oor       = background.publish_article :oor_article
        @invisible = background.publish_article :invisible_article

        alex.click 'articles'
      end

      it "should see regular and invisible articles" do
        [@oor, @invisible].each do |article|
          alex.see link: article.title
          alex.see article.sumary
        end
      end

      it "able to open article view page" do
        alex.click @oor.title

        alex.see  @oor.title,
                  @oor.sumary,
                  @oor.content

        alex.see 'edit'
      end

      it "able to open article edit page" do
        alex.click @oor.title,
                   'edit' # TODO Click edit near title...

        # check presence on a page by "be at page"
        current_path.should == background.edit_article_path(@oor)
      end
    end

    describe "edit article page" do
      it "should see article fields inside inputs tags" do
        within 'input' do alex.see @oor.title end
        within 'input' do alex.see @oor.sumary end
        within 'input' do alex.see @oor.content end
      end

      it "changes title" do
        alex.open_edit_article_page_for @oor

        fill_in "New title for OOR book" => :title
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New title for OOR book"
      end

      it "changes summary" do
        alex.open_edit_article_page_for @oor

        fill_in "New summary for OOR book" => :summary
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New summary for OOR book"
      end

      it "changes content" do
        alex.open_edit_article_page_for @oor

        fill_in "New content for OOR book" => :content
        click 'save'

        alex.see 'updated successfully'

        alex.open_article_listing
        alex.see "New content for OOR book"
      end
    end
  end

end
