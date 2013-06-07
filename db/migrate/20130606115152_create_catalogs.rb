class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.string :name
      t.text :document

      t.timestamps
    end
    
    add_index :catalogs,  :name
  end
end
