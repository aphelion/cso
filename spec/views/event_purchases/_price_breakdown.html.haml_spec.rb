include MoneyRails::ActionViewExtension

describe 'event_purchases/_price_breakdown.html.haml' do

  let(:event_purchase) { double(:event_purchase) }
  let(:event_purchase_base_price_value) { Money.new(100) }
  let(:event_purchase_processing_fees_value) { Money.new(200) }
  let(:event_purchase_total_price_value) { Money.new(300) }

  before do
    allow(view).to receive(:event_purchase_base_price).with(event_purchase).and_return(event_purchase_base_price_value)
    allow(view).to receive(:event_purchase_processing_fees).with(event_purchase).and_return(event_purchase_processing_fees_value)
    allow(view).to receive(:event_purchase_total_price).with(event_purchase).and_return(event_purchase_total_price_value)

    render partial: 'event_purchases/price_breakdown', locals: {event_purchase: event_purchase}
  end

  it 'renders the Ticket base price' do
    expect(rendered).to include(humanized_money_with_symbol event_purchase_base_price_value)
  end

  it 'renders the Ticket processing fees' do
    expect(rendered).to include(humanized_money_with_symbol event_purchase_processing_fees_value)
  end

  it 'renders the Ticket total price' do
    expect(rendered).to include(humanized_money_with_symbol event_purchase_total_price_value)
  end
end
