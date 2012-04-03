class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :init_feed

  private
  def init_feed
    @feed = Feed.new
  end
end
