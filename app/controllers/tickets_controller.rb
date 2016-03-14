include SessionsHelper

class TicketsController < ApplicationController
  before_action :logged_in_user

  def status
  end

  private
  def logged_in_user
    redirect_to new_session_path unless logged_in?
  end
end
