class AddGamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :games, :text
  end
end
