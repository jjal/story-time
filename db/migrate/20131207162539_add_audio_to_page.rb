class AddAudioToPage < ActiveRecord::Migration
  def change
    add_column :pages, :audio, :string
  end
end
