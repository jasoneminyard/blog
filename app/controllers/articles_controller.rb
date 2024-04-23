class ArticlesController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @count = Article.public_count
    if @count ==1
      @article = "article"
    else
      @article = "articles"
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated."
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = "Article was successfully deleted."
    else
      flash[:notice] = "Article was NOT deleted."
    end
    redirect_to root_path, status: :see_other
  end

    private
      def article_params
        params.require(:article).permit(:title, :body, :status, :author, :user_id)
      end
end
