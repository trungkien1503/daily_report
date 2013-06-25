# == Schema Information
#
# Table name: activations
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  activation_status :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Activation < ActiveRecord::Base
  attr_accessible :activation_status, :user_id
  belongs_to :user
  validate :activation_status,  presence: true
  validate :user_id,  presence: true
end
