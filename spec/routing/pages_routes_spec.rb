describe 'Pages routing' do
  it 'routes pages#index' do
    expect(get: '/').to route_to('pages#home')
  end

  it 'routes admin#index' do
    expect(get: '/admin').to route_to('admin#home')
  end
end
