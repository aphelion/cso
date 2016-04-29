describe 'event_purchases/_addon_selection.html.haml' do
  fixtures(:events)
  fixtures(:products)
  let(:event) { events(:bachata_party) }
  let(:event_purchase) { EventPurchase.new }

  before do
    event_purchase.event = event

    render partial: 'event_purchases/addon_selection', locals: {event_purchase: event_purchase}
  end

  it 'renders a button for each Addon' do
    event.addons.each do |addon|
      assert_select 'button', "Add #{addon.name}"
      expect(rendered).to have_text(addon.name)
    end
  end

  it 'renders the description for each Addon' do
    event.addons.each do |addon|
      expect(rendered).to have_text(addon.description)
    end
  end

  describe 'the Addon modal' do
    it 'renders a quantity dropdown menu' do
      event.addons.each do |addon|
        expect(rendered).to have_selector("#addon-modal-#{addon.id} [name='addon_#{addon.id}[quantity]']")
      end
    end
  end
end
