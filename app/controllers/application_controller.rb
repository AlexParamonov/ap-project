class ApplicationController < ActionController::Base
  include ExhibitsHelper

  protect_from_forgery

  private
  def feed
    @feed ||= exhibit(THE_FEED)
  end
  helper_method :feed
end
