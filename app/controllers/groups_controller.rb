class GroupsController < ApplicationController
  def create
    @group = Group.new(params[:group])
    if @group.save
      
    end
  end
end
