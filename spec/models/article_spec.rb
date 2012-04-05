require_relative '../spec_helper_lite'

require "active_model"
require_relative '../../app/models/article'

describe Article do
  let(:article) { Article.new }

  it "starts with blank attributes" do
    article.title.should be_nil
    article.summary.should be_nil
    article.content.should be_nil
  end

  it "supports reading and writing a title" do
    article.title = "new one"
    article.title.should eq "new one"
  end

  it "supports reading and writing a summary" do
    article.summary = "new one"
    article.summary.should eq "new one"
  end

  it "supports reading and writing a article content" do
    article.content = "new one"
    article.content.should eq "new one"
  end

  it "supports setting attributes in initializer" do
    article = Article.new(title: 'new title', summary: 'new summary', content: 'new content')
    article.title.should eq 'new title'
    article.summary.should eq 'new summary'
    article.content.should eq 'new content'
  end

  it "supports reading and writing a feed reference" do
    feed = Object.new
    article.feed = feed
    article.feed.should eq feed
  end

  it "is not valid with blank title" do
    [nil, "", " "].each do |bad_title|
      article.title = bad_title
      article.should_not be_valid
    end
  end

  it "is valid with non-blanck title" do
    article.title = "hey there"
    article.should be_valid
  end

  describe "#publish" do
    let(:feed) { mock(:feed) }
    before(:each) do
      article.feed = feed
      # TODO remove this dep
      article.stub(:valid?).and_return(true)
    end

    it "adds the article to the feed" do
      feed.should_receive(:add_entry).with(article)
      article.publish
    end


    describe "given an invaid article" do
      before(:each) do
        article.stub(:valid?).and_return(false)
      end

      it "wont add the article to the feed" do
        feed.should_not_receive(:add_entry)
        article.publish
      end

      # TODO change to raise exception
      it "returns false" do
        article.publish.should be_false
      end
    end
  end

  describe "#pubdate" do
    context "before publishing" do
      it "is nil" do
        article.pubdate.should be_nil
      end
    end

    context "after publishing" do
      before(:each) do
        @now = DateTime.parse "2012-04-04T13:54"
        @clock = mock
        @clock.stub(:now).and_return(@now)

        article.feed = mock.as_null_object
        # TODO remove this dep
        article.stub(:valid?).and_return(true)
        article.publish(@clock)
      end

      it "is a datetime" do
        article.pubdate.should be_kind_of DateTime
      end

      it "is current time" do
        article.pubdate.should be @now
      end
    end
  end
end
