describe 'event_purchases/_event_purchase.html.haml' do
  fixtures(:event_purchases)
  fixtures(:product_purchases)
  fixtures(:products)
  fixtures(:users)

  let(:event_purchase) { event_purchases(:crystals_event_purchase) }

  describe 'composition' do
    before do
      render_partial
    end

    it "renders the Event Purchase's Ticket's name" do
      expect(rendered).to have_text(event_purchase.ticket_purchase.product.name)
    end

    it "renders the Event Purchase's User's name" do
      expect(rendered).to have_text("#{event_purchase.user.first_name} #{event_purchase.user.last_name}")
    end

    it "renders the Event Purchase's Addons" do
      event_purchase.addon_purchases.each do |addon_purchase|
        expect(rendered).to have_text(addon_purchase.product.name)
      end
    end
  end

  context "when Addon's quantity is greater than 1" do
    before do
      event_purchase.addon_purchases.each do |addon_purchase|
        addon_purchase.quantity = 2
      end
      render_partial
    end

    it 'specifies the quantity' do
      event_purchase.addon_purchases.each do |addon_purchase|
        expect(rendered).to have_text("2x #{addon_purchase.product.name}")
      end
    end
  end

  context "when Addon's quantity is 1" do
    before do
      event_purchase.addon_purchases.each do |addon_purchase|
        addon_purchase.quantity = 1
      end
      render_partial
    end

    it 'does not specify the quantity' do
      event_purchase.addon_purchases.each do |addon_purchase|
        expect(rendered).to have_text("#{addon_purchase.product.name}")
        expect(rendered).to_not have_text("1x #{addon_purchase.product.name}")
      end
    end
  end

  def render_partial
    render partial: 'event_purchases/event_purchase', locals: {event_purchase: event_purchase}
  end
end
