include MoneyRails::ActionViewExtension

describe 'event_purchases/_form.html.haml' do
  fixtures(:events)
  fixtures(:products)
  fixtures(:users)
  let(:event) { events(:bachata_party) }
  let(:event_purchase) { EventPurchase.new }
  let(:ticket_purchase) { ProductPurchase.new }
  let(:user) { users(:young) }

  before do
    event_purchase.event = event
    event_purchase.ticket_purchase = ticket_purchase
    event.addons.each do |addon|
      event_purchase.addon_purchases << ProductPurchase.new(product: addon)
    end
  end

  describe 'the form' do

    before do
      render partial: 'event_purchases/form', locals: {event_purchase: event_purchase}
    end

    it 'submits POST to builds' do
      assert_select 'form[action=?][method=?]', event_event_purchases_path(event), 'post'
    end

    it 'instructs the User to choose a Ticket' do
      expect(rendered).to have_text('Choose a Ticket Option')
    end

    it 'lists each Ticket option' do
      event.tickets.each do |ticket|
        expect(rendered).to have_text("#{ticket.name} #{humanized_money_with_symbol ticket.price}")
      end
    end

    it 'adds Addon Purchases as hidden form elements' do
      event_purchase.addon_purchases.each_with_index do |addon_purchase, index|
        assert_select "input[type=hidden][value=?][name=?]", addon_purchase.product_id.to_s, "event_purchase[addon_purchases_attributes][#{index}][product_id]"
        assert_select "input[type=hidden][value=?][name=?]", addon_purchase.quantity.to_s, "event_purchase[addon_purchases_attributes][#{index}][quantity]"
      end
    end
  end

  context 'when a Ticket Option has been selected' do

    before do
      ticket_purchase.product = event.tickets.first

      allow(view).to receive(:event_purchase_total_price).with(event_purchase).and_return(Money.new(500))

      render partial: 'event_purchases/form', locals: {event_purchase: event_purchase, user: user}
    end

    it 'renders the Addon selection partial' do
      expect(view).to have_rendered(partial: 'event_purchases/_addon_selection', locals: {event_purchase: event_purchase})
    end

    it 'renders the Event Purchase Breakdown partial' do
      expect(view).to have_rendered(partial: 'event_purchases/_event_purchase_breakdown', locals: {event_purchase: event_purchase})
    end

    it 'renders a Stripe Checkout button' do
      expect(view).to have_rendered(partial: 'event_purchases/_checkout_button', locals: {
          email: user.email,
          name: event.name,
          description: ticket_purchase.product.name,
          amount: 500
      })
    end
  end

  context 'when a Ticket Option has not been selected' do
    before do
      event_purchase.event = event
      event_purchase.ticket_purchase = ticket_purchase

      render partial: 'event_purchases/form', locals: {event_purchase: event_purchase, user: user}
    end

    it 'does not render the Addon selection partial' do
      expect(view).to_not have_rendered(partial: 'event_purchase/_addon_selection')
    end

    it 'does not render the Event Purchase Breakdown partial' do
      expect(view).to_not have_rendered(partial: 'event_purchases/_event_purchase_breakdown', locals: {event_purchase: event_purchase})
    end

    it 'does not render a Stripe Checkout button' do
      expect(view).to_not have_rendered(partial: 'event_purchase/_checkout_button')
    end
  end
end
