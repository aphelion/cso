describe 'ticket_options/_form.html.haml' do
  fixtures(:events)
  fixtures(:ticket_options)

  describe 'basic form composition' do
    let(:event) { events(:bachata_party) }
    let(:ticket_option) { ticket_options(:bachata_party_full_pass) }
    before do
      render partial: 'ticket_options/form', locals: {event: event, ticket_option: ticket_option}
    end

    it 'renders a pre-populated input for name' do
      assert_select 'input#ticket_option_name[value=?]', ticket_option.name
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end
  end

  describe 'cancel button' do
    let(:event) { events(:bachata_party) }
    let(:ticket_option) { ticket_options(:bachata_party_full_pass) }
    context 'when cancel_path is supplied' do
      it 'renders a cancel button' do
        render partial: 'ticket_options/form', locals: {event: event, ticket_option: ticket_option, cancel_path: event_ticket_options_path(event)}
        assert_select 'a', 'Cancel', href: event_ticket_options_path(event)
      end
    end

    context 'when cancel_path is not supplied' do
      it 'does not render a cancel button' do
        render partial: 'ticket_options/form', locals: {event: event, ticket_option: ticket_option}
        assert_select 'a', {text: 'Cancel', count: 0}
      end
    end
  end

  context 'when Ticket Option is new' do
    let(:event) { events(:bachata_party) }
    let(:ticket_option) { TicketOption.new }

    before do
      render partial: 'ticket_options/form', locals: {event: event, ticket_option: ticket_option}
    end

    it 'submits POST to ticket_options' do
      assert_select 'form[action=?][method=?]', event_ticket_options_path(event), 'post'
    end
  end

  context 'when Ticket Option already exists' do
    let(:event) { events(:bachata_party) }
    let(:ticket_option) { ticket_options(:bachata_party_full_pass) }

    before do
      render partial: 'ticket_options/form', locals: {event: event, ticket_option: ticket_option}
    end

    it 'submits POST to the Ticket Option' do
      assert_select 'form[action=?][method=?]', event_ticket_option_path(event, ticket_option), 'post'
    end
  end
end
