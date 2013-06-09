class Group < ActiveRecord::Base
  attr_accessible :manager, :name
  has_many :users
  belongs_to :users
  validates :name, presence:true, uniqueness:{case_sensitive: false}
end
