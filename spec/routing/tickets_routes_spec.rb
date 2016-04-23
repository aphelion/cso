describe 'Tickets routing' do
  it { expect(get: '/tickets').to route_to('tickets#my') }
  it { expect(get: '/events/1/purchases/new').to route_to('event_purchases#new', event_id: '1') }
  it { expect(post: '/events/1/purchases').to route_to('event_purchases#create', event_id: '1') }
end
