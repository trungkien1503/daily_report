class GroupUsersController < ApplicationController
  before_filter 'correct_admin'
  def create
    @g_user = GroupUser.new(params['group_user'])
    @user = User.find(@g_user.user_id)
    GroupUser.destroy_by_user(@user)
    if @g_user.save
      @group = Group.find(@g_user.group_id)
      flash['success'] = "assigned user '#{@user.id}' to '#{@group.name}'"
      if params['manager'] == '1' && @user.activated?
        @user.manage!(@group)
        flash['success'] << ' as manager'
      end
    else
      flash['error'] = 'assign failed'
    end
    redirect_to users_path
  end

  private

  def correct_admin
    redirect_to root_path unless admin?
  end
end
