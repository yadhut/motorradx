class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
  def show  
    # @article = Article.find(params[:id]) 
    # we decleared before_action to perform the set_article method before running each function that we decleared with that
  end

  def index

    @articles = Article.all
  end

  def new

    @article = Article.new
    
  end

  def edit
    # @article = Article.find(params[:id])
  end


  def create
    
    # puts render plain: params[:article]
    @article = Article.new(article_params)
    @article.save
    Rails.logger.info @article.errors.full_messages
    if @article.errors.empty?
      flash[:notice] = "Article was successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update

    # @article = Article.find(params[:id])
    
    if @article.update(article_params)
      flash[:notice] = 'Article is successfully upadated'
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  # we are using this inside the two function above such as update and create. there we jus passing the function name insted of repeating the same code
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
end
