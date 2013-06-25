class Group < ActiveRecord::Base
  attr_accessible :manager, :name
  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :user
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
