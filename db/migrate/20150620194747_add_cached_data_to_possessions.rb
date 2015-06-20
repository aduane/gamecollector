class AddCachedDataToPossessions < ActiveRecord::Migration
  def change
    add_column :possessions, :game_title, :string
    add_column :possessions, :game_platform, :string
  end
end
