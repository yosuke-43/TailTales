class AddDogRefToBoards < ActiveRecord::Migration[7.1]
  def change
    add_reference :boards, :dog, foreign_key: true
  end
end
