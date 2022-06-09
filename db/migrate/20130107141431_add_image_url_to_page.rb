class AddImageUrlToPage < ActiveRecord::Migration
  def change
    add_column :pages, :image_url, :string
  end
end
