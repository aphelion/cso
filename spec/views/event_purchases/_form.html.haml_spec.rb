include MoneyRails::ActionViewExtension

describe 'event_purchases/_form.html.haml' do
  fixtures(:events)
  fixtures(:products)
  let(:event) { events(:bachata_party) }
  let(:event_purchase) { EventPurchase.new }
  let(:ticket_purchase) { ProductPurchase.new }

  before do
    event_purchase.event = event
    event_purchase.ticket_purchase = ticket_purchase
    render partial: 'event_purchases/form', locals: {event_purchase: event_purchase}
  end

  describe 'the form' do
    it 'submits POST to builds' do
      assert_select 'form[action=?][method=?]', event_event_purchases_path(event), 'post'
    end

    describe 'Ticket section' do
      it 'instructs the User to choose a Ticket' do
        expect(rendered).to have_text('Choose a Ticket Option')
      end

      it 'lists each Ticket option as a radio button' do
        event.tickets.each do |ticket|
          expect(rendered).to have_text("#{ticket.name} #{humanized_money_with_symbol ticket.price}")
        end
      end
    end

    describe 'Addons section' do
      it 'instructs the User to choose a Addons' do
        expect(rendered).to have_text('Choose Extras')
      end

      it 'lists each Ticket option as a radio button' do
        event.addons.each do |addon|
          expect(rendered).to have_text("#{addon.name} #{humanized_money_with_symbol addon.price}")
        end
      end
    end

    it 'renders a submit button' do
      assert_select 'input[type=?][value=?]', 'submit', 'Purchase'
    end
  end

  it 'renders a nested form to choose a Ticket' do
  end

  it 'renders a nested form to choose a Ticket' do
  end
end
