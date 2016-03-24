module SessionsConcern
  extend ActiveSupport::Concern

  def logged_in_user
    redirect_to new_session_path unless logged_in?
  end

  def admin_user
    head :forbidden unless current_user_admin?
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user_admin?
    !current_user.nil? and current_user.admin
  end

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

  def log_in(user)
    session[:user_id] = user.id if user and user.id
  end

  def user_model
    User
  end
end
