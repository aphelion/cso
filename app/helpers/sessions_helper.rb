module SessionsHelper
  def current_user
    @current_user ||= user_model.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def user_model
    User
  end
end
