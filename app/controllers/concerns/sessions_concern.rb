module SessionsConcern
  extend ActiveSupport::Concern

  def must_be_authenticated
    redirect_to new_session_path unless authenticated?
  end

  def must_be_admin
    head :forbidden unless admin?
  end

  def authenticated?
    !current_user.nil?
  end

  def admin?
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

  def authenticate(user)
    session[:user_id] = user.id if user and user.id
  end

  def user_model
    User
  end
end
