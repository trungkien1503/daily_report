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
#

class Report < ActiveRecord::Base
  attr_accessible :attached_file_data, :attached_file_name,
                  :catalog_id, :content, :user_id

  belongs_to :user
  belongs_to :catalog
  default_scope order: 'reports.created_at DESC'
  validates :user_id,     presence:true
  validates :catalog_id,  presence:true
  validates :content,     presence:true
end
