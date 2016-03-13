describe 'sessions routing' do
  it 'routes sessions#create' do
    expect(get: '/auth/facebook/callback').to route_to(controller: 'sessions', action: 'create', provider: 'facebook')
    expect(post: '/auth/facebook/callback').to route_to(controller: 'sessions', action: 'create', provider: 'facebook')
  end
end
