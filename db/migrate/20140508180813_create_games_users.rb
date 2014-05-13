class CreateGamesUsers < ActiveRecord::Migration
  def change
    create_table :games_users do |t|
    	t.integer :games_id
    	t.integer :users_id
    end
  end
end
