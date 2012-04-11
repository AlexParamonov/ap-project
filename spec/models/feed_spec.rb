require_relative "../spec_helper_lite"
require_relative "../../app/models/feed"

require "ostruct"
describe Feed do

  let(:feed)    { Feed.new(->{entries}) }
  let(:entries) { [] }

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
      entry = stub.as_null_object
      entry.should_receive(:load_attributes_to_persistence)
      feed.add_entry(entry)
      # feed.entries.should include entry
    end
  end

  # describe "#entries" do
  #   def stub_entry_with_date(date)
  #     OpenStruct.new(pubdate: DateTime.parse(date))
  #   end

  #   it "are sorted in reverce-chronological order" do
  #     oldest = stub_entry_with_date "2012-04-01"
  #     middle = stub_entry_with_date "2012-04-02"
  #     newest = stub_entry_with_date "2012-04-03"

  #     feed.add_entry oldest
  #     feed.add_entry newest
  #     feed.add_entry middle

  #     feed.entries.should eq [newest, middle, oldest]
  #   end

  #   # TODO WTF????
  #   it "are limited to 10 items" do
  #     10.times do |i|
  #       feed.add_entry stub_entry_with_date "2012-04-#{i+1}"
  #     end

  #     oldest = stub_entry_with_date "2012-03-30"
  #     feed.add_entry oldest

  #     feed.should have(10).entries
  #     feed.entries.should_not include oldest
  #   end
  # end
end
