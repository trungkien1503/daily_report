class ActivationsController < ApplicationController
  def update
    @activation = Activation.find(params[:id])
    @user = User.find(@activation.user_id)
    if @user.group_user
      @activation.update_attributes(params[:activation])
    end
    respond_to do |format|
      format.html{ redirect_back_or root_path}
      format.js {}
    end
  end
end
