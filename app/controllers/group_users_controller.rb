class GroupUsersController < ApplicationController
  before_filter :correct_admin
  def create
    @group_user = GroupUser.new(params[:group_user])
    @group = Group.find(@group_user.group_id)
    @group.manager = @group_user.user_id
    if @group.save and @group_user.save
      flash[:success] = "updated success"
    else
      flash[:error] = "updated failed"
    end
    redirect_to users_path
  end

  private

  def correct_admin
    redirect_to root_path unless admin?
  end
end
