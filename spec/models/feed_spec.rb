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
  end
end
