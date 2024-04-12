class BookmarksController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.bookmark(@board)

    render turbo_stream: turbo_stream.replace(
      "bookmark_button_area_#{@board.id}",
      partial: 'boards/bookmark_button',
      locals: { board: @board }
    )
  end

  def destroy
    @board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(@board)

    render turbo_stream: turbo_stream.replace(
      "bookmark_button_area_#{@board.id}",
      partial: 'boards/bookmark_button',
      locals: { board: @board }
    )
  end
end
