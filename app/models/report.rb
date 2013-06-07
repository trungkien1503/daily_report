# == Schema Information
#
# Table name: reports
#
#  id                 :integer          not null, primary key
#  catalog_id         :integer
#  user_id            :integer
#  content            :text
#  attached_file_data :binary
#  attached_file_name :string(255)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attached_file_type :string(255)
#

class Report < ActiveRecord::Base
  attr_accessible :attached_file_data, :attached_file_name,
                  :catalog_id, :content, :user_id

  mount_uploader :attached_file_name, AttachmentUploader

  belongs_to :user
  belongs_to :catalog

  default_scope order: 'reports.created_at DESC'

  validates :user_id,     presence:true
  validates :catalog_id,  presence:true
  validates :content,     presence:true
  validate :file_size_validation, :if => "attached_file_name?"
  def file_size_validation
    errors[:attached_file_data] << "should be less than 1MB" if attached_file_data.size > 1.megabytes
  end
end
