class ArticlesController < ApplicationController
  def new
    @article = @feed.new_article
  end

  def create
    @article = @feed.new_article(params[:article])
    # TODO remove if-else
    if @article.publish
      redirect_to root_path, notice: "Article added"
    else
      render 'new'
    end
  end
end
