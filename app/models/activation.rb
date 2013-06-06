class Activation < ActiveRecord::Base
  attr_accessible :activation_status, :user_id
  
  belongs_to :user 
  
  validate :user_id,  presence:true
  validate :activation_status,  presence:true
end
