module ChargesService
  extend self

  def charge_customer(customer, amount, description)
    stripe_charge = stripe_charge_service.create(
        customer: customer.customer_id,
        amount: amount,
        description: description,
        currency: 'USD'
    )

    charge_model.create(
        charge_id: stripe_charge.id,
        processor: 'stripe'
    )
  end

  def charge_model
    Charge
  end

  def stripe_charge_service
    Stripe::Charge
  end
end
