EventPurchase.destroy_all
ProductPurchaseOptionChoice.destroy_all
ProductPurchase.destroy_all
Charge.destroy_all
ProductOption.destroy_all
Product.destroy_all
Event.destroy_all
Identity.destroy_all
Customer.destroy_all
User.destroy_all

cso_2017 = Event.create(
    name: '2017 Collegiate Salsa Open',
    description: 'Returning for the second year, the Collegiate Salsa Open is the premiere salsa summit where dancers from colleges and communities all over California come together to celebrate our unique salsa scene through competitions, performances, and all-night social dancing. The CSO is organized by the college dance community for the college dance community.',
    time_zone: 'Pacific Time (US & Canada)',
    event_start: DateTime.new(2017, 5, 7, 16, 30),
    event_end: DateTime.new(2017, 5, 8, 3, 30),
    sale_start: DateTime.new(2017, 1, 1),
    sale_end: DateTime.new(2017, 5, 7)
)

cso_2017.tickets << Product.create(
    name: 'Full Pass',
    price_cents: 2900,
    description: 'A Full Pass entitles you to everything your heart has ever wanted. Get this one.'
)

spectator_ticket = Product.create(
    name: 'Spectator Pass',
    price_cents: 800,
    description: "Get a Spectator Pass if you can't dance but need to see your kid do this salsa thing."
)

cso_2017.tickets << spectator_ticket

cso_2017.tickets << Product.create(
    name: 'Evening Pass',
    price_cents: 2200,
    description: "You're older, finished (or never went to) college, and want to come to hit on the college chicks--this one's for you."
)

cso_2017_shirt = Product.create(
    name: 'CSO 2017 Shirt',
    price_cents: 1200,
    description: 'Rep the CSO! Give us money! Swag!'
)

cso_2017_shirt_special_womens = Product.create(
    name: 'CSO 2017 Shirt',
    price_cents: 1200,
    description: 'Rep the CSO! Give us money! Swag!'
)

cso_2017_shirt_mo_money = Product.create(
    name: 'Women Fancy Flowy CSO Shirt',
    price_cents: 1400,
    description: "It's sensitive. Just like you. And shows more skin. Just like you. Women's fancy flowy CSO shirt. Just for you."
)

ProductOption.create(product: cso_2017_shirt, name: 'Gender', choices: ['Male', 'Female'])
ProductOption.create(product: cso_2017_shirt, name: 'Size', choices: ['XS', 'S', 'M', 'L', 'XL'])
ProductOption.create(product: cso_2017_shirt, name: 'Color', choices: ['Tiedie', 'See-Through', 'Black'])

cso_water_bottle = Product.create(
    name: 'CSO Water Bottle',
    price_cents: 900,
    description: "Stay hydrated, fill it with Redbull vodka, we don't care. Just buy it."
)

ProductOption.create(product: cso_water_bottle, name: 'Color', choices: ['Red', 'Black'])

cso_2017.addons << [cso_2017_shirt, cso_2017_shirt_special_womens, cso_2017_shirt_mo_money, cso_water_bottle, spectator_ticket]

cso_2016 = Event.create(
    name: '2016 Collegiate Salsa Open',
    description: 'Returning for the second year, the Collegiate Salsa Open is the premiere salsa summit where dancers from colleges and communities all over California come together to celebrate our unique salsa scene through competitions, performances, and all-night social dancing. The CSO is organized by the college dance community for the college dance community.',
    time_zone: 'Pacific Time (US & Canada)',
    event_start: DateTime.new(2016, 5, 7, 16, 30),
    event_end: DateTime.new(2016, 5, 8, 3, 30),
    sale_start: DateTime.new(2016, 2, 1, 22),
    sale_end: DateTime.new(2016, 5, 7)
)

cso_2016_full_pass = Product.create(
    name: 'Full Pass',
    price_cents: 2900,
    description: 'A Full Pass entitles you to everything your heart has ever wanted. Get this one.'
)

cso_2016.tickets << cso_2016_full_pass

spectator_ticket = Product.create(
    name: 'Spectator Pass',
    price_cents: 800,
    description: "Get a Spectator Pass if you can't dance but need to see your kid do this salsa thing."
)

cso_2016.tickets << spectator_ticket

cso_2016.tickets << Product.create(
    name: 'Evening Pass',
    price_cents: 2200,
    description: "You're older, finished (or never went to) college, and want to come to hit on the college chicks--this one's for you."
)

cso_2016_shirt = Product.create(
    name: 'CSO 2016 Shirt',
    price_cents: 1200,
    description: 'Rep the CSO! Give us money! Swag!'
)

ProductOption.create(product: cso_2016_shirt, name: 'Gender', choices: ['Male', 'Female'])
ProductOption.create(product: cso_2016_shirt, name: 'Size', choices: ['XS', 'S', 'M', 'L', 'XL'])
ProductOption.create(product: cso_2016_shirt, name: 'Color', choices: ['Tiedie', 'See-Through', 'Black'])

cso_water_bottle = Product.create(
    name: 'CSO Water Bottle',
    price_cents: 900,
    description: "Stay hydrated, fill it with Redbull vodka, we don't care. Just buy it."
)

ProductOption.create(product: cso_water_bottle, name: 'Color', choices: ['Red', 'Black'])

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
    price_cents: 1600,
    description: "Dancin' all summer long."
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

cso_2015_full_pass = Product.create(
    name: 'Full Pass',
    price_cents: 2800,
    description: "You're OG CSO. Thanks for the love."
)

cso_2015.tickets << cso_2015_full_pass


me = User.create(email: 'lennykoepsell@gmail.com', first_name: 'Leonhardt', last_name: 'Koepsell')
my_charge_2015 = Charge.create(charge_id: 'charge-1', processor: 'stripe')
my_cso_2015_full_pass = ProductPurchase.create(product: cso_2015_full_pass, charge: my_charge_2015, quantity: 1)
EventPurchase.create(user: me, ticket_purchase: my_cso_2015_full_pass, event: cso_2015)
my_charge_2016 = Charge.create(charge_id: 'charge-2', processor: 'stripe')
my_cso_2016_full_pass = ProductPurchase.create(product: cso_2016_full_pass, charge: my_charge_2016, quantity: 1)
EventPurchase.create(user: me, ticket_purchase: my_cso_2016_full_pass, event: cso_2016)

admin = User.create(email: 'leonhardt@koepsell.io', first_name: 'Leonhardt', last_name: 'Koepsell', admin: true)