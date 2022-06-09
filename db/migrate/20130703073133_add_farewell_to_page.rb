class AddFarewellToPage < ActiveRecord::Migration
  def change
    add_column :pages, :farewell, :string
  end
end
