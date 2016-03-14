module SessionsHelper
  def current_user
    @current_user ||= user_model.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in(user)
    session[:user_id] = user.id if user and user.id
  end

  def user_model
    User
  end
end
