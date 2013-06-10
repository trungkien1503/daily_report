class GroupUsersController < ApplicationController
  before_filter :correct_admin
  def create
    @group_user = GroupUser.new(params[:group_user])
    @olds = GroupUser.find_all_by_user_id(@group_user.user_id)
    if @olds
      @olds.each do |f|
      GroupUser.destroy(f.id)  
      end
    end
    @group = Group.find(@group_user.group_id)

    if @group_user.save
      if(params[:manager]=="1")
        @group.manager = @group_user.user_id
        @group.save
      end
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
