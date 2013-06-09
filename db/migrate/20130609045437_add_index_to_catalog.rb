class AddIndexToCatalog < ActiveRecord::Migration
  def change
    add_index :catalogs, :name, unique:true
  end
end
