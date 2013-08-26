class DropBooleansFromPages < ActiveRecord::Migration
  def up
  	remove_column :pages, :success
  	remove_column :pages, :end
  end

  def down 
  	add_column :pages, :success, :boolean
	add_column :pages, :end, :boolean
  end
end
