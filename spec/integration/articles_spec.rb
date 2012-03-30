require_relative "../spec_helper"

describe "Articles" do
  context "As reader" do
    context "listing articles" do
      before(:each) do
        @oor = Factory(:oor_article)
        @js = Factory(:js_article)

        click 'articles'
      end

      it "should list existing articles" do
        [@oor, @js].each do |article|
          see link: article.title
          see article.sumary
        end
      end

      specify "open article page" do
        click @oor.title

        see @oor.title,
            @oor.sumary,
            @oor.content
      end
    end
  end

  context "As admin" do
    context "listing articles" do
      before(:each) do
        @oor = Factory(:oor_article)
        @invisible = Factory(:invisible_article)

        click 'articles'
      end

      it "should list all articles" do
        [@oor, @invisible].each do |article|
          see link: article.title
          see article.sumary
        end
      end

      specify "open article page" do
        click @oor.title

        see @oor.title,
            @oor.sumary,
            @oor.content
        see 'edit'
      end

      specify "open edit article page" do
        click @oor.title,
              'edit'

        within 'input' {see @oor.title}
        within 'input' {see @oor.sumary}
        within 'input' {see @oor.content}
      end

      it "change article" do
        open_edit_article_page_for @oor # TODO implement in admin role using DCI
        fill_in "New title for OOR book" => :title

        click 'save'
        see 'updated successfully'

        open_article_listing # TODO implement in admin role using DCI
        see "New title for OOR book"
      end
    end
  end

end
