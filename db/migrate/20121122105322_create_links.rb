class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :page_id
      t.integer :other_page_id
      t.string :text

      t.timestamps
    end
  end
end
