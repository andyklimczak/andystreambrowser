class DropGamesUsersTable < ActiveRecord::Migration
  def up
  	drop_table :games_users
  end
  def down
  end
end
