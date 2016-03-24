describe 'sessions routing' do
  it 'routes sessions#callback' do
    expect(get: '/sessions/facebook/callback').to route_to(controller: 'sessions', action: 'callback', provider: 'facebook')
    expect(post: '/sessions/facebook/callback').to route_to(controller: 'sessions', action: 'callback', provider: 'facebook')
  end

  it 'routes sessions#new' do
    expect(get: '/sessions/new').to route_to('sessions#new')
  end

  it 'routes sessions#destroy' do
    expect(delete: '/sessions').to route_to('sessions#destroy')
  end
end
