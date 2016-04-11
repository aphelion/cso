describe 'event_purchases/_event_purchase.html.haml' do
  fixtures(:event_purchases)
  fixtures(:product_purchases)
  fixtures(:products)
  fixtures(:users)

  let(:event_purchase) { event_purchases(:crystals_event_purchase) }

  before do
    render partial: 'event_purchases/event_purchase', locals: {event_purchase: event_purchase}
  end

  it "renders the Event Purchase's Ticket's name" do
    expect(rendered).to have_text(event_purchase.ticket_purchase.product.name)
  end

  it "renders the Event Purchase's User's name" do
    expect(rendered).to have_text("#{event_purchase.user.first_name} #{event_purchase.user.last_name}")
  end
end
