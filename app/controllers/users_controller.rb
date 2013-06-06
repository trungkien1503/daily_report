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
    @user.activation_token = Digest::MD5::hexdigest(@user.email.downcase)
    if @user.save
      #       activation for user responses to user.id
      @activation = Activation.new(user_id: @user.id, activation_status: "inactive")
      @activation.save
      # Tell the UserMailer to send a Email after save
      UserMailer.welcome_email(@user).deliver
      UserMailer.active_email(@user).deliver
      redirect_to @user
    else
      render 'new'
    end
  end

  def activate
    if (@user = User.find_by_activation_token(params[:id]))
      User.activate(@user)
      redirect_to @user
    else
      redirect_to root_path
    end
  end
end
