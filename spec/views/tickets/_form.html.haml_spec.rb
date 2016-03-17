describe 'tickets/_form.html.haml' do
  fixtures(:events)
  fixtures(:tickets)

  describe 'basic form composition' do
    let(:event) { events(:bachata_party) }
    let(:ticket) { tickets(:bachata_party_full_pass) }
    before do
      render partial: 'tickets/form', locals: {event: event, ticket: ticket}
    end

    it 'renders a pre-populated input for name' do
      assert_select 'input#ticket_name[value=?]', ticket.name
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end
  end

  describe 'cancel button' do
    let(:event) { events(:bachata_party) }
    let(:ticket) { tickets(:bachata_party_full_pass) }
    context 'when cancel_path is supplied' do
      it 'renders a cancel button' do
        render partial: 'tickets/form', locals: {event: event, ticket: ticket, cancel_path: event_tickets_path(event)}
        assert_select 'a', 'Cancel', href: event_tickets_path(event)
      end
    end

    context 'when cancel_path is not supplied' do
      it 'does not render a cancel button' do
        render partial: 'tickets/form', locals: {event: event, ticket: ticket}
        assert_select 'a', {text: 'Cancel', count: 0}
      end
    end
  end

  context 'when Ticket is new' do
    let(:event) { events(:bachata_party) }
    let(:ticket) { Ticket.new }

    before do
      render partial: 'tickets/form', locals: {event: event, ticket: ticket}
    end

    it 'submits POST to tickets' do
      assert_select 'form[action=?][method=?]', event_tickets_path(event), 'post'
    end
  end

  context 'when Ticket already exists' do
    let(:event) { events(:bachata_party) }
    let(:ticket) { tickets(:bachata_party_full_pass) }

    before do
      render partial: 'tickets/form', locals: {event: event, ticket: ticket}
    end

    it 'submits POST to ticket' do
      assert_select 'form[action=?][method=?]', event_ticket_path(event, ticket), 'post'
    end
  end
end
