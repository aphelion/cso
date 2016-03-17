describe 'events routing' do
  it { expect(get: '/events').to route_to('events#index') }
  it { expect(get: '/events/new').to route_to('events#new') }
  it { expect(post: '/events').to route_to('events#create') }
  it { expect(put: '/events/1').to route_to('events#update', id: '1') }
end
