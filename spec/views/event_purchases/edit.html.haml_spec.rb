describe 'event_purchases/edit.html.haml' do
  fixtures(:event_purchases)
  fixtures(:events)
  fixtures(:users)
  let(:event_purchase) { event_purchases(:crystals_salsa_party_purchase) }
  let(:user) { users(:crystal) }

  before do
    assign(:event_purchase, event_purchase)
    assign(:user, user)
    render
  end

  it 'renders an instructional title' do
    expect(rendered).to have_text("Modify Your #{event_purchase.event.name} Ticket")
  end

  it 'renders the Addon selection partial' do
    expect(view).to have_rendered(partial: 'event_purchases/_addon_selection', locals: {event_purchase: event_purchase})
  end

  it 'renders the Event Purchase selection partial' do
    expect(view).to have_rendered(partial: 'event_purchases/_event_purchase', locals: {event_purchase: event_purchase})
  end
end
