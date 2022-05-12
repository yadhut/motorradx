class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]
  def show  
    # @article = Article.find(params[:id]) 
    # we decleared before_action to perform the set_article method before running each function that we decleared with that
  end

  def index

    @articles = Article.paginate(page: params[:page], per_page: 8)
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
    @article.user = current_user
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

  def require_same_user

    if current_user != @article.user
        flash[:notice] ="You only allowded to update your articles!"
        redirect_to @article
    end
end
  
end
