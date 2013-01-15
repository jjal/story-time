class ChangeImageUrls < ActiveRecord::Migration
  def up
    change_column :stories, :image_url, :string, :limit => 1024
    change_column :pages, :image_url, :string, :limit => 1024
  end

  def down
    change_column :stories, :image_url, :string, :limit => nil
    change_column :pages, :image_url, :string, :limit => nil
  end
end
