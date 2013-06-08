class AddFileToReports < ActiveRecord::Migration
  def change
    add_column :reports, :file, :string
  end
end
