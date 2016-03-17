describe 'users/tickets.html.haml' do
  before do
    render
  end

  it 'renders a title' do
    expect(rendered).to have_text('Ticket')
  end
end
