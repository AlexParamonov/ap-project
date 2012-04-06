class ApplicationController < ActionController::Base
  include ExhibitsHelper

  protect_from_forgery
  before_filter :init_feed

  private
  def init_feed
    @feed = exhibit(THE_FEED)
  end
end
