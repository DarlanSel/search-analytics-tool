class ArticlesController < ApplicationController
  before_action :analyze_search_query

  def index
    @articles = Article.all
    @articles = @articles.by_title(params[:query]) if params[:query].present?

    @analytics = ArticleSearch.all

    if turbo_frame_request?
      render partial: 'articles', locals: { articles: @articles, analytics: @analytics }
    else
      render :index
    end
  end

  private

  def analyze_search_query
    analyzer = SearchAnalyticsTool::Analyzer.new(current_query: params[:query].to_s)
    session[:queries_history] = analyzer.run
  end
end
