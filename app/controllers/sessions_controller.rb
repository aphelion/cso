class SessionsController < ApplicationController
  include SessionsHelper

  def callback
    auth_hash = request.env['omniauth.auth']
    identity = identities_service.find_or_create_by_auth_hash(auth_hash)
    user = users_service.find_or_create_by_identity(identity)
    log_in user
    redirect_to tickets_status_path
  end

  def new
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  def identities_service
    IdentitiesService.new
  end

  def users_service
    UsersService.new
  end
end