describe 'Tickets routing' do
  it { expect(get: '/events/1/tickets/new').to route_to('tickets#new', event_id: '1') }
  it { expect(post: '/events/1/tickets').to route_to('tickets#create', event_id: '1') }
  it { expect(get: '/tickets/1').to route_to('tickets#show', id: '1') }
  it { expect(delete: '/tickets/1').to route_to('tickets#destroy', id: '1') }
end
