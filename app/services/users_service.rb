module UsersService
  extend self

  def find_or_create_by_identity_and_auth_hash(identity, auth_hash)
    if identity.user
      identity.user
    else

      user = user_model.find_by(email: auth_hash['info']['email']) || create_new_user(auth_hash)

      identity.user = user
      identity.save
      user
    end
  end

  def find_or_create_customer(user, processor_token)
    return user.customer unless user.customer.nil?

    stripe_customer = stripe_customer_service.create(
        description: "#{user.first_name} #{user.last_name}",
        email: user.email,
        source: processor_token
    )

    customer_model.create(
        user: user,
        customer_id: stripe_customer.id,
        processor: 'stripe'
    )
  end

  def user_model
    User
  end

  def customer_model
    Customer
  end

  def stripe_customer_service
    Stripe::Customer
  end

  private
  def create_new_user(auth_hash)
    user_model.create(
        email: auth_hash['info']['email'],
        first_name: auth_hash['info']['first_name'],
        last_name: auth_hash['info']['last_name']
    )
  end
end
