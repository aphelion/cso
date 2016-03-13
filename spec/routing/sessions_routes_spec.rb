describe 'sessions routing' do
  it 'routes sessions#callback' do
    expect(get: '/sessions/callback/facebook').to route_to(controller: 'sessions', action: 'callback', provider: 'facebook')
    expect(post: '/sessions/callback/facebook').to route_to(controller: 'sessions', action: 'callback', provider: 'facebook')
  end

  it 'routes sessions#new' do

  end
end
