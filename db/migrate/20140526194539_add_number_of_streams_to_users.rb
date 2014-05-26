class AddNumberOfStreamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number_of_streams, :integer
  end
end
