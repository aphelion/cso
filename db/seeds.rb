EventPurchase.destroy_all
Product.destroy_all
Event.destroy_all

cso_2016 = Event.create(
    name: '2016 Collegiate Salsa Open',
    description: 'Returning for the second year, the Collegiate Salsa Open is the premiere salsa summit where dancers from colleges and communities all over California come together to celebrate our unique salsa scene through competitions, performances, and all-night social dancing. The CSO is organized by the college dance community for the college dance community.',
    time_zone: 'Pacific Time (US & Canada)',
    event_start: DateTime.new(2016, 5, 7, 16, 30),
    event_end: DateTime.new(2016, 5, 8, 3, 30),
    sale_start: DateTime.new(2016, 2, 1, 22),
    sale_end: DateTime.new(2016, 5, 7)
)

cso_2016.tickets << Product.create(
    name: 'Full Pass',
    price_cents: 2900
)

spectator_ticket = Product.create(
    name: 'Spectator Pass',
    price_cents: 800
)

cso_2016.tickets << spectator_ticket

cso_2016.tickets << Product.create(
    name: 'Evening Pass',
    price_cents: 2200
)

cso_2016_shirt = Product.create(
    name: 'CSO 2016 Shirt',
    price_cents: 1200
)

cso_water_bottle = Product.create(
    name: 'CSO Water Bottle',
    price_cents: 900
)

cso_2016.addons << [cso_2016_shirt, cso_water_bottle, spectator_ticket]

summer_2016 = Event.create(
    name: 'Summer 2016 LDA Party',
    description: 'The Latin Dance Association hosts is first social this summer. Get back together with the college scene over the summer and help raise money to support the CSO!',
    time_zone: 'Pacific Time (US & Canada)',
    event_start: DateTime.new(2016, 7, 30, 21),
    event_end: DateTime.new(2016, 7, 31, 2),
    sale_start: DateTime.new(2016, 3, 1),
    sale_end: DateTime.new(2016, 7, 30)
)

summer_2016.tickets << Product.create(
    name: 'Full Pass',
    price_cents: 1600
)

summer_2016.addons << [cso_2016_shirt, cso_water_bottle]

cso_2015 = Event.create(
    name: '2015 Collegiate Salsa Open',
    description: 'The Collegiate Salsa Open is the premiere salsa summit where dancers from colleges and communities all over California will come together to celebrate our unique salsa scene through competitions, performances, and all-night social dancing. The CSO is organized by the college dance community for the college dance community.',
    time_zone: 'Pacific Time (US & Canada)',
    event_start: DateTime.new(2015, 4, 25, 16, 30),
    event_end: DateTime.new(2015, 4, 26, 4, 30),
    sale_start: DateTime.new(2015, 2, 1, 22),
    sale_end: DateTime.new(2015, 4, 25)
)

cso_2015.tickets << Product.create(
    name: 'Full Pass',
    price_cents: 2800
)
