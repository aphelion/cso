describe 'Events routing' do
  it { expect(get: '/events').to route_to('events#index') }
  it { expect(get: '/events/new').to route_to('events#new') }
  it { expect(post: '/events').to route_to('events#create') }
  it { expect(put: '/events/1').to route_to('events#update', id: '1') }
  it { expect(get: '/events/1/edit').to route_to('events#edit', id: '1') }
  it { expect(get: '/events/1/confirmation').to route_to('events#confirmation', id: '1') }

  it { expect(get: '/events/1/tickets').to route_to('tickets#index', event_id: '1') }
  it { expect(get: '/events/1/tickets/new').to route_to('tickets#new', event_id: '1') }
  it { expect(post: '/events/1/tickets').to route_to('tickets#create', event_id: '1') }
  it { expect(put: '/events/1/tickets/2').to route_to('tickets#update', event_id: '1', id: '2') }
  it { expect(get: '/events/1/tickets/2/edit').to route_to('tickets#edit', event_id: '1', id: '2') }
end
