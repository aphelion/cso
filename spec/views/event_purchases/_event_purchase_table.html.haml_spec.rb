describe 'event_purchases/_event_purchase_table.html.haml' do
  fixtures(:event_purchases)
  let(:tickets) { [event_purchases(:crystals_winter_zouk_purchase), event_purchases(:crystals_bachata_party_purchase)] }

  before do
    render partial: 'event_purchases/event_purchase_table', locals: {event_purchases: tickets}
  end

  it 'renders the Event name for each Event Purchase' do
    tickets.each do |ticket|
      expect(rendered).to have_text(ticket.event.name)
    end
  end

  it 'renders the Event date each Event Purchase' do
    tickets.each do |ticket|
      expect(rendered).to have_text(ticket.event.event_start.strftime('%B %e, %Y'))
    end
  end

  it 'renders a link to the Ticket details' do
    tickets.each do |ticket|
      expect(rendered).to have_link 'Details', event_purchase_path(ticket)
    end
  end
end
