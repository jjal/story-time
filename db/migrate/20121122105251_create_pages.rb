class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :id
      t.integer :story_id
      t.string :image
      t.string :title
      t.string :text
      t.boolean :end
      t.boolean :success
      t.integer :points

      t.timestamps
    end
  end
end
