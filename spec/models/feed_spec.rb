require_relative "../spec_helper_lite"
require_relative "../../app/models/feed"

require "ostruct"
describe Feed do
  let (:feed) { Feed.new }
  it { feed.entries.should be_empty }
  # it "has no entries" do
  #   feed.entries.should be_empty
  # end

  describe "#new_article" do
    before(:each) do
      @new_article = OpenStruct.new
      feed.article_source = -> { @new_article }
    end

    it "returns new article" do
      feed.new_article.should eq @new_article
    end

    it "sets the article's feed reference to itself" do
      feed.new_article.feed.should eq feed
    end

    it "accepts an attribute hash" do
      article_source = mock(:article_source)
      article_source.should_receive(:call).with(x:1, y:2).and_return(stub.as_null_object)

      feed.article_source = article_source
      feed.new_article(x:1, y:2)
    end
  end

  describe "#add_entry" do
    it "adds the entry to the feed" do
      entry = Object.new
      feed.add_entry(entry)
      feed.entries.should include entry
    end
  end
end
