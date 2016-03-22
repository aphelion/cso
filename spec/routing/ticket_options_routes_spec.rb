describe 'Ticket Options routing' do
  it { expect(get: '/events/1/ticket_options').to route_to('ticket_options#index', event_id: '1') }
  it { expect(get: '/events/1/ticket_options/new').to route_to('ticket_options#new', event_id: '1') }
  it { expect(post: '/events/1/ticket_options').to route_to('ticket_options#create', event_id: '1') }
  it { expect(put: '/events/1/ticket_options/2').to route_to('ticket_options#update', event_id: '1', id: '2') }
  it { expect(get: '/events/1/ticket_options/2/edit').to route_to('ticket_options#edit', event_id: '1', id: '2') }
end
