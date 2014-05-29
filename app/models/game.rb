class Game < ActiveRecord::Base
	has_and_belongs_to_many :users, :join_table => "games_users"
end
