describe 'Tickets routing' do
  it { expect(get: '/tickets').to route_to('tickets#my') }
end
