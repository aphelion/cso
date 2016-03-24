class SessionsController < ApplicationController
  include SessionsHelper

  def callback
    auth_hash = request.env['omniauth.auth']
    identity = identities_service.find_or_create_by_auth_hash(auth_hash)
    user = users_service.find_or_create_by_identity_and_auth_hash(identity, auth_hash)
    log_in user
    redirect_to user_tickets_path
  end

  def new
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  def identities_service
    IdentitiesService
  end

  def users_service
    UsersService
  end
end
