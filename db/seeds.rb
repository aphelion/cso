Ticket.destroy_all
TicketOption.destroy_all
Event.destroy_all

cso_2016 = Event.create(
    name: '2016 Collegiate Salsa Open',
    event_start: DateTime.new(2016, 5, 7, 16, 30),
    event_end: DateTime.new(2016, 5, 8, 3, 30),
    sale_start: DateTime.new(2016, 2, 1, 22),
    sale_end: DateTime.new(2016, 5, 7)
)

TicketOption.create(
    event: cso_2016,
    name: 'Full Pass',
    price_cents: 3000
)

TicketOption.create(
    event: cso_2016,
    name: 'Spectator Pass',
    price_cents: 1000
)

TicketOption.create(
    event: cso_2016,
    name: 'Evening Pass',
    price_cents: 2000
)

cso_2015 = Event.create(
    name: '2015 Collegiate Salsa Open',
    event_start: DateTime.new(2015, 4, 25, 16, 30),
    event_end: DateTime.new(2015, 4, 26, 4, 30),
    sale_start: DateTime.new(2015, 2, 1, 22),
    sale_end: DateTime.new(2015, 4, 25)
)

TicketOption.create(
    event: cso_2015,
    name: 'Full Pass'
)
