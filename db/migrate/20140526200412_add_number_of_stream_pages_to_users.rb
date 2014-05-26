class AddNumberOfStreamPagesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :number_of_stream_pages, :integer
  end
end
