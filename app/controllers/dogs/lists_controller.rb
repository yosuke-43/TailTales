class Dogs::ListsController < ApplicationController
  def index
    limited_breeds = params[:limited_breeds]
    
    if limited_breeds == 'limited_display'
      @list_dogs = Dog.where('breed LIKE ? AND display_in_index = ?', "%#{params[:breed]}%", 1)
    else
      @list_dogs = Dog.where('breed LIKE ?', "%#{params[:breed]}%")
    end
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @list_dogs }
    end
  end
end
