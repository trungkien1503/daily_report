class AddAttachedFileTypeToReports < ActiveRecord::Migration
  def change
    add_column :reports, :attached_file_type, :string
  end
end
