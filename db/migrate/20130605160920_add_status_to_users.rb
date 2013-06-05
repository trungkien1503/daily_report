class AddStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status_id, :int
  end
end
