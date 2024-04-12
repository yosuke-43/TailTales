class Dogs::ListsController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    limited_breeds = params[:limited_breeds]
    
    if limited_breeds == 'limited_display'
      @list_dogs = Dog.where('breed LIKE ? AND display_in_index = ?', "%#{params[:breed]}%", 1).order(:breed)
    else
      @list_dogs = Dog.where('breed LIKE ?', "%#{params[:breed]}%").order(:breed)
    end
    respond_to do |format|
      format.html { redirect_to :root }
      format.json { render json: @list_dogs }
    end
  end
end
