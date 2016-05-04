describe 'Tickets routing' do
  it { expect(get: '/tickets').to route_to('tickets#my') }
  it { expect(get: '/events/1/purchases/new').to route_to('event_purchases#new', event_id: '1') }
  it { expect(post: '/events/1/purchases').to route_to('event_purchases#create', event_id: '1') }
  it { expect(post: '/events/1/purchases/calculate').to route_to('event_purchases#calculate_new', event_id: '1') }
  it { expect(post: '/purchases/1/calculate').to route_to('event_purchases#calculate_edit', id: '1') }
end
