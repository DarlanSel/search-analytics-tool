class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @articles = @articles.by_title(params[:query]) if params[:query].present?

    if turbo_frame_request?
      render partial: 'articles', articles: @articles
    else
      render :index
    end
  end
end
