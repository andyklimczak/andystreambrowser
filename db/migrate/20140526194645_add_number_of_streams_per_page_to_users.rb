class AddNumberOfStreamsPerPageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number_of_streams_per_page, :integer
  end
end
