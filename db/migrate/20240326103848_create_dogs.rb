class CreateDogs < ActiveRecord::Migration[7.1]
  def change
    create_table :dogs do |t|
      t.string :breed, null: false
      t.string :height
      t.string :weight
      t.integer :hair_length
      t.references :dog_size_type, null: false, foreign_key: true
      t.string :dog_image
      t.references :dog_country, null: false, foreign_key: true
      t.integer :activity_level
      t.integer :solitude_tolerance
      t.integer :care_difficulty
      t.text :catchphrase
      t.text :features_sentence
      t.text :personality_sentence
      t.text :history_sentence
      t.text :recommended_for_whom
      t.integer :display_in_index, default: 0

      t.timestamps
    end
  end
end
