class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    @user.password = @user.password_confirmation = User.auto_generate_password
    @user.status_id = 0
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
end
