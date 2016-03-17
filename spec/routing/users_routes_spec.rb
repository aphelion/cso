describe 'users routing' do
  it 'routes users#tickets' do
    expect(get: '/tickets').to route_to('users#tickets')
  end
end
