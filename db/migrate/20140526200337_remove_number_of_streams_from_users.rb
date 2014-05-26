class RemoveNumberOfStreamsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :number_of_streams, :integer
  end
end
