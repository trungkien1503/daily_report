class GroupUser < ActiveRecord::Base
  attr_accessible :group_id, :user_id
  belongs_to :group
  belongs_to :user
  class << self
    def destroy_by_user(user)
      gr_user = GroupUser.find_by_user_id(user.id)
      destroy(gr_user)
    end
  end
end
