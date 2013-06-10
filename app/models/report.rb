# == Schema Information
#
# Table name: reports
#
#  id         :integer          not null, primary key
#  catalog_id :integer
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  file       :string(255)
#

class Report < ActiveRecord::Base
  attr_accessible :catalog_id, :content, :user_id, :file

  mount_uploader :file, AttachmentUploader

  belongs_to :user
  belongs_to :catalog

  default_scope order: 'reports.created_at DESC'

  validates :user_id,     presence:true
  validates :catalog_id,  presence:true
  validates :content,     presence:true
  validate :file_size_validation, :if => "file?"
  def file_size_validation
    if file.file.size.to_f/(1000*1000) > 1.to_f
      errors.add(:file, "You cannot upload a file greater than 1MB")
    end
  end
  def week
    created_at.strftime("%W")
  end
  def month
    created_at.strftime("%m")
  end
  def year
    created_at.strftime("%Y")
  end
end
