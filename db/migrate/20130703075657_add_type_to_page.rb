class AddTypeToPage < ActiveRecord::Migration
  def change
    add_column :pages, :type, :string
  end
end
