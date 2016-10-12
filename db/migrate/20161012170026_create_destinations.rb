class CreateDestinations < ActiveRecord::Migration[5.0]
  def change
    create_table :destinations do |t|
      t.string :title
      t.text :content
      t.string :location
      t.string :recommendation
      t.integer :food_id
      t.integer :user_id

      t.timestamps
    end
  end
end
