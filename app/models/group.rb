class Group < ActiveRecord::Base
  attr_accessible :manager, :name
  has_many :group_users
  has_many :users, through: :group_users
  belongs_to :user
  
  default_scope order: 'groups.id ASC'
  validates :name, presence:true, uniqueness:{case_sensitive: false}
end
