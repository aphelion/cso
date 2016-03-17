describe 'events routing' do
  it { expect(get: '/events').to route_to('events#index') }
  it { expect(get: '/events/new').to route_to('events#new') }
  it { expect(post: '/events').to route_to('events#create') }
end
