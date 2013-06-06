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
    @success = false
    if @user.save
      #       activation for user responses to user.id
      @activation = Activation.new(user_id: @user.id, activation_status: "inactive")
      if @activation.save
        @success = true
        # Tell the UserMailer to send a Email after save
        UserMailer.welcome_email(@user).deliver
        UserMailer.active_email(@user).deliver
      end
    end
    unless @success
      flash.now[:error] = 'signup failed'
      render 'new'
    else
      flash.now[:message] = 'signup success, check mail for password'
      render 'sessions/new'
    end
    
  end

  def activate
    if (@user = User.find_by_activation_token(params[:id]))
      User.activate(@user)
      flash.now[:message] = 'activation success'
    else
      flash.now[:message] = 'activation failed'
    end
    render 'static_pages/home'
  end
end
