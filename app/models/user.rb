# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  email            :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  password_digest  :string(255)
#  activation_token :string(255)
#  remember_token   :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  
  has_one :activation, dependent: :destroy
  has_many :reports,    dependent: :destroy
  belongs_to :groups
  has_one :group, dependent: :nullify, foreign_key: "manager", readonly: true
  before_save { email.downcase! }
  before_save :create_remember_token
  
  validates :name,  presence: true,  length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+-.]+@framgia.com\z/i
  # VALID_EMAIL_REGEX_ = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: {case_sensitive: false}
  validates :password,              presence: true, length: { minimum: 6 }, :on => :update
  validates :password_confirmation, presence: true, :on => :update
  validates :activation_token,      presence: true, :on => :create
  
  def self.auto_generate_password
    (0..5).map{ ('a'..'z').to_a[rand(26)] }.join
  end
  
  def self.activate(user)
    @user = user
    @activation = Activation.find_by_user_id(@user.id)
    Activation.update(@activation.id, activation_status:"activated")
  end
  
  def activated?
    activation.activation_status == "activated"
  end
  private
  
  def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
  end
end
