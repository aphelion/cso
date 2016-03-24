describe TicketsHelper do
  describe 'object seams' do
    it { expect(helper.tickets_service).to be(TicketsService) }
  end

  describe '.ticket_for_event_for_current_user' do
    let(:tickets_service) { double(:TicketsService) }
    let(:user) { double(:user) }
    let(:event) { double(:event) }
    let(:ticket) { double(:ticket) }

    before do
      allow(helper).to receive(:tickets_service).and_return(tickets_service)
      allow(helper).to receive(:current_user).and_return(user)
      allow(tickets_service).to receive(:ticket_for_event_for_user).with(user, event).and_return(ticket)
    end

    it 'determines if the current User has tickets for the provided Event' do
      expect(helper.ticket_for_event_for_current_user(event)).to be(ticket)
    end
  end
end
