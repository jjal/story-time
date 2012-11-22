class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :story_id
      t.integer :page_id
      t.integer :fails
      t.integer :wins
      t.integer :pages
      t.boolean :active

      t.timestamps
    end
  end
end
