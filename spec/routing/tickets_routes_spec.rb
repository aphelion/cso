describe 'tickets routing' do
  it 'routes tickets#status' do
    expect(get: '/tickets').to route_to('tickets#status')
  end
end
