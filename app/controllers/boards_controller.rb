class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  before_action :set_dog_choice, only: %i[new edit]
  skip_before_action :require_login, only: [:index, :show]

  def new
    @board = Board.new
    @dogs = Dog.all.order(breed: :asc)
  end

  def create
    @board = current_user.boards.build(board_params)
    
    if @board.save
      redirect_back_or_to boards_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      @dogs = Dog.all.order(breed: :asc)
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result.includes(:user, :dog).order(created_at: :desc).page(params[:page]).per(10)
  end

  def bookmarks
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user, :dog).order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit;end 

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    redirect_to boards_path, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  # -------------------------------------------------------------------------------------------------------
  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def set_dog_choice
    @dogs = Dog.all.order(breed: :asc)
  end

  def board_params
    params.require(:board).permit(:title, :body, :dog_id, :board_image, :board_image_cache)
  end

end
