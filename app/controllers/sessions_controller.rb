class SessionsController < ApplicationController

  def callback
    auth_hash = request.env['omniauth.auth']
    identity = Identity.find_or_create_by_omniauth(auth_hash)

    unless identity.user
      if session[:user_id]
        identity.user = User.find(session[:user_id])
      else
        identity.user = User.create
      end
      identity.save
    end

    session[:user_id] = identity.user.id

    redirect_to root_path
  end
end
