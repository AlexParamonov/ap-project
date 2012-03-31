class FeedController < ApplicationController
  def index
    @feed = Feed.new
    article1 = @feed.new_article
    article1.title   = "Hypermedia API"
    article1.summary = "New look at API"
    article1.content = "Versioning API sucks!"
    article1.publish

    article2.title   = "Objects on Rails"
    article2.summary = "or Avdi knows the truth"
    article2.content = "Rails AR sucks!"
    article2.publish
  end
end
