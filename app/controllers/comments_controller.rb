class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)
    @board = Board.find(params[:board_id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)

    if @comment.save
      @comment = Comment.new
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Comment.model_name.human)
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy!
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(board_id: params[:board_id])
  end
end
