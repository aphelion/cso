include MoneyRails::ActionViewExtension

describe 'event_purchases/show.html.haml' do
  fixtures(:event_purchases)
  fixtures(:products)
  fixtures(:events)
  fixtures(:users)
  let(:event_purchase) { event_purchases(:crystals_event_purchase) }

  before do
    assign(:event_purchase, event_purchase)
    render
  end

  it 'greets the User by name' do
    expect(rendered).to have_text(event_purchase.user.first_name)
  end

  it 'reminds the User which Ticket Option they purchased' do
    expect(rendered).to have_text(event_purchase.ticket_purchase.product.name)
  end

  it 'indicates which Event this Ticket is for' do
    expect(rendered).to have_text(event_purchase.event.name)
  end

  it 'renders the Ticket partial' do
    expect(view).to have_rendered(partial: 'event_purchases/_event_purchase', locals: {event_purchase: event_purchase})
  end

  it 'renders the Event Purchase breakdown' do
    expect(view).to have_rendered(partial: 'event_purchases/_event_purchase_breakdown', locals: {event_purchase: event_purchase, user: event_purchase.user})
  end

  it 'renders a link back to the Tickets page' do
    assert_select 'a[href=?]', my_tickets_path, text: 'Back'
  end
end
