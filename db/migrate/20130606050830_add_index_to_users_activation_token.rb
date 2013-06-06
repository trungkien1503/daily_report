class AddIndexToUsersActivationToken < ActiveRecord::Migration
  def change
    add_index :users, :activation_token, unique:true
  end
end
