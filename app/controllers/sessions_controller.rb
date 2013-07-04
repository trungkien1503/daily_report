class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params['session']['email'].downcase)
    # binding.pry
    if user && user.authenticate(params['session']['password'])

      activation = Activation.find_by_user_id(user.id)
      if activation.activation_status == 'activated'
        sign_in user
        session[:user_id] = user.id
        redirect_back_or user
      else
        flash.now['error'] = 'account hasnot been actived. Ask admin'
        render 'sessions/new'
      end
    else
      flash.now['error'] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    sign_out
    session[:user_id] = nil
    redirect_to root_url
  end
end
