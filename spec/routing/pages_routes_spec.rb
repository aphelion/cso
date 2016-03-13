describe 'pages routing' do
  it 'routes pages#index' do
    expect(get: '/').to route_to('pages#home')
  end
end
