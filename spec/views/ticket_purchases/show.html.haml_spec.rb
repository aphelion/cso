describe 'ticket_purchases/show.html.haml' do
  fixtures(:events, :users)
  let(:event) { events(:salsa_party) }
  let(:user) { users(:crystal) }

  before do
    assign(:event, event)
    assign(:user, user)
    render
  end

  it 'tells the user they have a Ticket Purchase' do
    expect(rendered).to have_text(event.name)
    expect(rendered).to have_text(user.first_name)
  end
end
