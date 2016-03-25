describe 'events/_form.html.haml' do
  fixtures(:events)

  describe 'basic form composition' do
    let(:event) { events(:bachata_party) }
    before do
      render partial: 'events/form', locals: {event: event}
    end

    it 'renders a pre-populated input for name' do
      assert_select 'input#event_name[value=?]', event.name
    end

    it 'renders a pre-populated input for description' do
      puts rendered
      assert_select 'textarea#event_description', event.description
    end

    it 'renders a pre-populated input for event_start' do
      assert_select 'input#event_event_start[value=?]', format_datetime_local(event.event_start)
    end

    it 'renders a pre-populated input for event_end' do
      assert_select 'input#event_event_end[value=?]', format_datetime_local(event.event_end)
    end

    it 'renders a pre-populated input for sale_start' do
      assert_select 'input#event_sale_start[value=?]', format_datetime_local(event.sale_start)
    end

    it 'renders a pre-populated input for sale_end' do
      assert_select 'input#event_sale_end[value=?]', format_datetime_local(event.sale_end)
    end

    it 'renders a submit button' do
      assert_select 'input[type=?]', 'submit'
    end
  end

  describe 'cancel button' do
    let(:event) { events(:bachata_party) }
    context 'when cancel_path is supplied' do
      it 'renders a cancel button' do
        render partial: 'events/form', locals: {event: event, cancel_path: event_path(event)}
        assert_select 'a', 'Cancel', href: event_path(event)
      end
    end

    context 'when cancel_path is not supplied' do
      it 'does not render a cancel button' do
        render partial: 'events/form', locals: {event: event}
        assert_select 'a', {text: 'Cancel', count: 0}
      end
    end
  end

  context 'when Event is new' do
    let(:event) { Event.new }

    before do
      render partial: 'events/form', locals: {event: event}
    end

    it 'submits POST to events' do
      assert_select 'form[action=?][method=?]', events_path, 'post'
    end
  end

  context 'when Event already exists' do
    let(:event) { events(:bachata_party) }

    before do
      render partial: 'events/form', locals: {event: event}
    end

    it 'submits POST to event' do
      assert_select 'form[action=?][method=?]', event_path(event), 'post'
    end
  end
end

def format_datetime_local(datetime)
  datetime.try(:strftime, '%Y-%m-%dT%T')
end
