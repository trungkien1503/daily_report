class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :catalog_id
      t.integer :user_id
      t.text :content
      t.binary :attached_file_data
      t.string :attached_file_name
      t.timestamps
    end
    
    add_index :reports, :created_at
    add_index :reports, :user_id
    add_index :reports, :catalog_id
    add_index :reports, [:user_id, :created_at]
  end
end
