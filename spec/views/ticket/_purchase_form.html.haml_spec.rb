describe 'tickets/_purchase_form.html.haml' do
  fixtures(:events)
  fixtures(:users)

  let(:event) { events(:bachata_party) }
  let(:ticket) { Ticket.new }
  let(:user) { users(:young) }
  let(:price) { Money.new(500) }

  describe 'form composition' do
    before do
      render partial: 'tickets/purchase_form.html.haml', locals: {event: event, ticket: ticket, user: user}
    end

    it 'renders a list of Ticket Options to choose from' do
      event.ticket_options.each do |ticket_option|
        assert_select 'label', text: /#{ticket_option.name}/
        assert_select 'input[type="radio"][value=?]', ticket_option.id.to_s
      end
    end

    it 'submits POST to Tickets' do
      assert_select 'form[action=?][method=?]', event_tickets_path(event), 'post'
    end
  end

  context 'when a Ticket Option has been selected' do
    before do
      ticket.ticket_option = event.ticket_options.first
      render partial: 'tickets/purchase_form.html.haml', locals: {event: event, ticket: ticket, user: user}
    end

    it 'renders the Ticket price breakdown' do
      expect(view).to have_rendered(partial: 'tickets/_ticket_price_breakdown', locals: {event: event, ticket: ticket})
    end

    it 'renders a Stripe Checkout button' do
      expect(view).to have_rendered(partial: 'tickets/_checkout_button', locals: {
          email: user.email,
          name: event.name,
          description: ticket.ticket_option.name,
          amount: ticket_total_price(ticket).cents
      })
    end
  end

  context 'when a Ticket Option has not been selected' do
    before do
      render partial: 'tickets/purchase_form.html.haml', locals: {event: event, ticket: ticket, user: user}
    end

    it 'does not render the Ticket price breakdown' do
      expect(view).to_not have_rendered(partial: 'tickets/_ticket_price_breakdown')
    end

    it 'does not render a Stripe Checkout button' do
      expect(view).to_not have_rendered(partial: 'tickets/_checkout_button')
    end
  end
end
