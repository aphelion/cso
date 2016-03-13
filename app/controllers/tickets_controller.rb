class TicketsController < ApplicationController
  def status
    redirect_to new_session_path unless session[:user_id]
  end
end
