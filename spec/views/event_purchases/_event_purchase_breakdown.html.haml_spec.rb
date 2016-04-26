include MoneyRails::ActionViewExtension

describe 'event_purchases/_event_purchase_breakdown.html.haml' do
  fixtures(:event_purchases)
  fixtures(:product_purchases)
  let(:event_purchase) { event_purchases(:crystals_event_purchase)}

  let(:event_purchase_base_price_value) { Money.new(100) }
  let(:event_purchase_processing_fees_value) { Money.new(200) }
  let(:event_purchase_total_price_value) { Money.new(300) }

  before do
    allow(view).to receive(:event_purchase_base_price).with(event_purchase).and_return(event_purchase_base_price_value)
    allow(view).to receive(:event_purchase_processing_fees).with(event_purchase).and_return(event_purchase_processing_fees_value)
    allow(view).to receive(:event_purchase_total_price).with(event_purchase).and_return(event_purchase_total_price_value)
  end

  context 'basic structure' do
    before do
      render partial: 'event_purchases/event_purchase_breakdown', locals: {event_purchase: event_purchase, user: event_purchase.user}
    end

    it 'lists the Ticket and its price' do
      ticket_purchase = event_purchase.ticket_purchase
      expect(rendered).to have_text("#{ticket_purchase.product.name} for #{event_purchase.user.full_name} #{humanized_money_with_symbol ticket_purchase.total_price}")
    end

    it 'lists each Addon, its quantity, and its price' do
      event_purchase.addon_purchases.each do |addon_purchase|
        expect(rendered).to have_text("#{addon_purchase.product.name} #{addon_purchase.quantity}x #{humanized_money_with_symbol addon_purchase.total_price}")
      end
    end

    it 'renders the Event Purchase subtotal' do
      expect(rendered).to have_text(humanized_money_with_symbol event_purchase_base_price_value)
    end

    it 'renders the Event Purchase processing fees' do
      expect(rendered).to have_text(humanized_money_with_symbol event_purchase_processing_fees_value)
    end

    it 'renders the Event Purchase total price' do
      expect(rendered).to have_text(humanized_money_with_symbol event_purchase_total_price_value)
    end
  end

  context 'when editable is true' do
    before do
      render partial: 'event_purchases/event_purchase_breakdown', locals: {event_purchase: event_purchase, user: event_purchase.user, editable: true}
    end

    it 'renders a remove button for each Addon' do
      event_purchase.addon_purchases.each do |addon_purchase|
        expect(rendered).to have_text("#{addon_purchase.product.name} #{addon_purchase.quantity}x #{humanized_money_with_symbol addon_purchase.total_price}")
      end
    end
  end
end
