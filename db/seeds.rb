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
    name: 'Full Pass'
)

TicketOption.create(
    event: cso_2016,
    name: 'Spectator Pass'
)

TicketOption.create(
    event: cso_2016,
    name: 'Evening Pass'
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
