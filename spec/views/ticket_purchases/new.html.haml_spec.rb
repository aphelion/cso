describe 'ticket_purchases/new.html.haml' do
  fixtures(:events)
  fixtures(:tickets)

  describe 'basic form composition' do
    let(:event) { events(:bachata_party) }
    let(:ticket) { tickets(:bachata_party_full_pass) }
    let(:ticket_purchase) { TicketPurchase.new }

    before do
      assign(:event, event)
      assign(:ticket, ticket)
      assign(:ticket_purchase, ticket_purchase)
      render template: 'ticket_purchases/new'
    end

    it 'submits POST to ticket purchases' do
      assert_select 'form[action=?][method=?]', event_ticket_ticket_purchases_path(event, ticket), 'post'
    end

    it 'renders a submit button' do
      assert_select 'input[type=?][value=?]', 'submit', 'Purchase'
    end
  end
end
