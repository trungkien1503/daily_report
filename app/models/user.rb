# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  status_id       :integer
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :status_id
  has_secure_password
  
  before_save { email.downcase! }
  
  validates :name,  presence: true,  length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+-.]+@framgia.com\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
  validates :password,              presence: true, length: { minimum: 6 }, :on => :update
  validates :password_confirmation, presence: true, :on => :update

  def self.auto_generate_password
    (0..5).map{ ('a'..'z').to_a[rand(26)] }.join
  end
end
