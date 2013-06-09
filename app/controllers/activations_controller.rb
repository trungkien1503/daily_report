class ActivationsController < ApplicationController
  def update
    @activation = Activation.find(params[:id])
    @user = User.find(@activation.user_id)
    if(@user.group_id)
      @activation.update_attributes(params[:activation])
      respond_to do |format|
        format.html{ redirect_back_or root_path}
        format.js {}
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js {}
      end
    end
  end
end
