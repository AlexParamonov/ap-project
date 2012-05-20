class ArticlesController < ApplicationController
  respond_to :html, :json

  def new
    @article = feed.new_article
  end

  def show
    @article = exhibit(feed.article(params[:id]))
    respond_with(@article)
  end

  def create
    @article = feed.new_article(params[:article])
    # TODO remove if-else
    if @article.publish
      redirect_to root_path, notice: "Article added"
    else
      render 'new'
    end
  end

  private
  attr_reader :article
  helper_method :article
end
