describe 'users/tickets.html.haml' do
  fixtures(:events)
  let(:salsa_party) { events(:salsa_party) }
  let(:purchasable_events) { [salsa_party] }

  before do
    assign(:purchasable_events, purchasable_events)
    render
  end

  it 'renders a title' do
    expect(rendered).to have_text('Ticket')
  end

  it 'lists the purchasable events' do
    expect(rendered).to have_text(salsa_party.name)
  end
end
