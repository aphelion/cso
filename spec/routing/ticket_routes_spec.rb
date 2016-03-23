describe 'Tickets routing' do
  it { expect(get: '/events/1/ticket_options/2/tickets/new').to route_to('tickets#new', event_id: '1', ticket_option_id: '2') }
  it { expect(post: '/events/1/ticket_options/2/tickets').to route_to('tickets#create', event_id: '1', ticket_option_id: '2') }
  it { expect(get: '/tickets/1').to route_to('tickets#show', id: '1') }
end