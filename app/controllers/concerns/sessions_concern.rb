module SessionsConcern
  extend ActiveSupport::Concern
  include SessionsHelper

  def logged_in_user
    redirect_to new_session_path unless logged_in?
  end
end
