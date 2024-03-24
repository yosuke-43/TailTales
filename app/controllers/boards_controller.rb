class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  skip_before_action :require_login, only: [:index, :show]

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_back_or_to boards_path, success: t('.success')
    else
      flash.now[:danger] = t('.fail')
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show
    @board = Board.find(params[:id])
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

  def bookmarks
    @bookmark_boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc)
  end

  # -------------------------------------------------------------------------------------------------------
  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :body)
  end

end
