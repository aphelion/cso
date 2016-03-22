describe 'TicketPurchases routing' do
  it { expect(get: '/events/1/tickets/2/ticket_purchases/new').to route_to('ticket_purchases#new', event_id: '1', ticket_id: '2') }
  it { expect(post: '/events/1/tickets/2/ticket_purchases').to route_to('ticket_purchases#create', event_id: '1', ticket_id: '2') }
  it { expect(get: '/ticket_purchases/1').to route_to('ticket_purchases#show', id: '1') }
end
