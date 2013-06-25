# == Schema Information
#
# Table name: catalogs
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  document   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Catalog < ActiveRecord::Base
  attr_accessible :document, :name
  has_many :reports,    dependent: :destroy
  validates :document,  presence: true
  validates :name,      presence: true,  uniqueness: { case_sensitive: false }
end
