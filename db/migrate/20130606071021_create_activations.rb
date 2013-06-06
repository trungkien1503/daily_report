class CreateActivations < ActiveRecord::Migration
  def change
    create_table :activations do |t|
      t.integer :user_id
      t.string :activation_status

      t.timestamps
    end
    add_index :activations, :user_id, unique:true
  end
end
