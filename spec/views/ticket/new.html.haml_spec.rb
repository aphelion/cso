include MoneyRails::ActionViewExtension

describe 'tickets/new.html.haml' do
  fixtures(:events)
  fixtures(:ticket_options)

  describe 'basic form composition' do
    let(:event) { events(:bachata_party) }
    let(:ticket_option) { ticket_options(:bachata_party_full_pass) }
    let(:ticket) { Ticket.new }

    before do
      assign(:event, event)
      assign(:ticket_option, ticket_option)
      assign(:ticket, ticket)
      render template: 'tickets/new'
    end

    it 'submits POST to Tickets' do
      assert_select 'form[action=?][method=?]', event_ticket_option_tickets_path(event, ticket_option), 'post'
    end

    it 'shows the price' do
      expect(rendered).to have_text humanized_money_with_symbol(ticket_option.price)
    end

    it 'renders a submit button' do
      assert_select 'input[type=?][value=?]', 'submit', 'Purchase'
    end
  end
end
