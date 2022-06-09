class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :id
      t.string :image
      t.string :title
      t.integer :user_id

      t.timestamps
    end
  end
end
