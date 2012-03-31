require_relative '../spec_helper_lite'
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

  describe "#publish" do
    let(:feed) { mock(:feed) }
    before(:each) do
      article.feed = feed
    end

    it "adds the article to the feed" do
      feed.should_receive(:add_entry).with(article)
      article.publish
    end
  end
end
