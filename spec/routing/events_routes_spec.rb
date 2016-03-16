describe 'events routing' do
  it { expect(get: '/events').to route_to('events#index') }
end
