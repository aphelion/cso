module SessionsHelper
  def current_user
    return @current_user if @current_user
    return nil unless session[:user_id]

    if (found_user = user_model.find_by(id: session[:user_id]))
      @current_user = found_user
    else
      session.delete(:user_id)
      nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in(user)
    session[:user_id] = user.id if user and user.id
  end

  def current_user_admin?
    !current_user.nil? and current_user.admin
  end

  def user_model
    User
  end
end
