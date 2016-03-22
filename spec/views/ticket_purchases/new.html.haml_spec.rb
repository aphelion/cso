describe 'ticket_purchases/new.html.haml' do
  fixtures(:events)
  fixtures(:ticket_options)

  describe 'basic form composition' do
    let(:event) { events(:bachata_party) }
    let(:ticket_option) { ticket_options(:bachata_party_full_pass) }
    let(:ticket_purchase) { TicketPurchase.new }

    before do
      assign(:event, event)
      assign(:ticket_option, ticket_option)
      assign(:ticket_purchase, ticket_purchase)
      render template: 'ticket_purchases/new'
    end

    it 'submits POST to Ticket Purchases' do
      assert_select 'form[action=?][method=?]', event_ticket_option_ticket_purchases_path(event, ticket_option), 'post'
    end

    it 'renders a submit button' do
      assert_select 'input[type=?][value=?]', 'submit', 'Purchase'
    end
  end
end
