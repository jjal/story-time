class RemoveImageFromPage < ActiveRecord::Migration
  def up
    remove_column :pages, :image
  end

  def down
    add_column :pages, :image, :string
  end
end
