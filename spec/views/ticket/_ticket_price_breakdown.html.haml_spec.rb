include MoneyRails::ActionViewExtension

describe 'tickets/_ticket_price_breakdown.html.haml' do

  let(:ticket) { double(:ticket) }
  let(:ticket_base_price_value) { Money.new(100) }
  let(:ticket_processing_fees_value) { Money.new(200) }
  let(:ticket_total_price_value) { Money.new(300) }

  before do
    allow(view).to receive(:ticket_base_price).with(ticket).and_return(ticket_base_price_value)
    allow(view).to receive(:ticket_processing_fees).with(ticket).and_return(ticket_processing_fees_value)
    allow(view).to receive(:ticket_total_price).with(ticket).and_return(ticket_total_price_value)

    render partial: 'tickets/ticket_price_breakdown', locals: {ticket: ticket}
  end

  it 'renders the Ticket base price' do
    expect(rendered).to include(humanized_money_with_symbol ticket_base_price_value)
  end

  it 'renders the Ticket processing fees' do
    expect(rendered).to include(humanized_money_with_symbol ticket_processing_fees_value)
  end

  it 'renders the Ticket total price' do
    expect(rendered).to include(humanized_money_with_symbol ticket_total_price_value)
  end
end
