class SessionsController < ApplicationController
  def create
    if user = User.find_by(uid: uid)
      user.update(token: token, refresh_token: refresh_token)
    else
      user = User.create(uid: uid,
      display_name: display_name, 
      token: token, 
      refresh_token: refresh_token) 
    end
    session[:user_id] = user.id
    flash[:success] = "Welcome, #{user.display_name}!"
    redirect_to '/recommendations/new'
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
  
  private
  
  def auth_hash
    request.env['omniauth.auth']
  end

  def uid
    auth_hash['uid']
  end

  def display_name
    auth_hash['extra']['raw_info']['display_name']
  end

  def token
    auth_hash['credentials']['token']
  end

  def refresh_token
    auth_hash['credentials']['refresh_token']
  end
end
