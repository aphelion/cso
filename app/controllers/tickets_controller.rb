class TicketsController < ApplicationController
  def status
    redirect_to sessions_new_path unless session[:user_id]
  end
end
