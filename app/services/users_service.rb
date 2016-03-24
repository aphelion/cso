module UsersService
  extend self

  def find_or_create_by_identity_and_auth_hash(identity, auth_hash)
    if identity.user
      identity.user
    else

      user = user_model.find_by(email: auth_hash['info']['email']) || _create_new_user(auth_hash)

      identity.user = user
      identity.save
      user
    end
  end

  def _create_new_user(auth_hash)
    user_model.create(
        email: auth_hash['info']['email'],
        first_name: auth_hash['info']['first_name'],
        last_name: auth_hash['info']['last_name']
    )
  end

  def user_model
    User
  end
end
