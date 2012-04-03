class ArticlesController < ApplicationController
  def new
    @article = @feed.new_article
  end

  def create
    @article = @feed.new_article(params[:article])
    @article.publish

    redirect_to root_path, notice: "Article added"
  end
end
