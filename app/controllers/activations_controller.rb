class ActivationsController < ApplicationController
  def update
    @activation = Activation.find(params[:id])
    @user = User.find(@activation.user_id)
    @activation.update_attributes(params[:activation]) if @user.group_user
    respond_to do |format|
      format.html { redirect_back_or root_path }
      format.js {}
    end
  end
end
