class UsersService
  def user_model
    User
  end

  def find_or_create_by_identity(identity)
    if identity.user
      identity.user
    else
      user = user_model.create
      identity.user = user
      identity.save
      user
    end
  end
end
