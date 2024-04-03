class Dogs::ListsController < ApplicationController
  def index
    @list_dogs = Dog.where('breed LIKE ? AND display_in_index = ?', "%#{params[:breed]}%", 1)
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @list_dogs }
    end
  end
end
