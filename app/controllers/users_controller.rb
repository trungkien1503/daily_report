class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  def show
    if signed_in?
      redirect_to root_path
    else
      @user = User.find(params[:id])
    end
  end

  def new
    @user = User.new
  end

  def create
    if signed_in?
      redirect_to root_path
    else
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

  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
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

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
end
