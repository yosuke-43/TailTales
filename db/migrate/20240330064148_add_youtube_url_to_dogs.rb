class AddYoutubeUrlToDogs < ActiveRecord::Migration[7.1]
  def change
    add_column :dogs, :youtube_url, :string
  end
end
