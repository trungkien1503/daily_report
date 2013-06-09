class ActivationsController < ApplicationController
  def update
    @activation = Activation.find(params[:id])
    @activation.update_attributes(params[:activation])
    @user = User.find(@activation.user_id)
    respond_to do |format|
      format.html{ redirect_back_or root_path}
      format.js {}
    end
  end
end
