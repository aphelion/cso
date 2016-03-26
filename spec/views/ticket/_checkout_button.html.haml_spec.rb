describe 'tickets/_checkout_button.html.haml' do
  let(:email) { 'EMAIL' }
  let(:name) { 'NAME' }
  let(:description) { 'DESCRIPTION' }
  let(:amount) { 'AMOUNT' }

  before do
    Rails.configuration.stripe[:publishable_key] = 'KEY' unless Rails.configuration.stripe[:publishable_key]

    render partial: 'tickets/checkout_button.html.haml', locals: {email: email, name: name, description: description, amount: amount}
  end
  it 'renders a Stripe Checkout button' do
    assert_select 'script[src=?][data-email=?][data-name=?][data-key=?][data-description=?][data-amount=?]',
                  'https://checkout.stripe.com/checkout.js',
                  email,
                  name,
                  Rails.configuration.stripe[:publishable_key],
                  description,
                  amount
  end
end
