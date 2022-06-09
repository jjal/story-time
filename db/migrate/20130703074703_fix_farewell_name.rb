class FixFarewellName < ActiveRecord::Migration
  def up
  	rename_column :pages, :farewell, :message
  end

  def down
  	rename_column :pages, :message, :farewell
  end
end
