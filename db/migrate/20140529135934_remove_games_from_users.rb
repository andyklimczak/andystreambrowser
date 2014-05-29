class RemoveGamesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :games, :text
  end
end
