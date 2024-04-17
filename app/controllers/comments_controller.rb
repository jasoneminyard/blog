class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    @article = Article.find(params[:article_id])
    
    if @comment = @article.comments.create(comment_params)
      flash[:notice] = "Comment was successfully created."
    else
      flash[:warning] = "Comment was NOT created."
    end
    
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    if @comment.destroy
      flash[:notice] = "Comment was successfully deleted."
    else
      flash[:warning] = "Comment was NOT deleted."
    end

    redirect_to article_path(@article), status: :see_other
  end

    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status, :user_id)
      end
end
