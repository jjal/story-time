class ChangePagesText < ActiveRecord::Migration
  def up
    change_column :stories, :description, :text
    change_column :pages, :text, :text
  end

  def down
    change_column :stories, :description, :text
    change_column :pages, :text, :text
  end
end
