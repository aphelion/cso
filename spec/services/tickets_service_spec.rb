describe TicketsService do
  describe 'object seams' do
    describe '.ticket_model' do
      it { expect(subject.ticket_model).to be(Ticket) }
    end
  end

  describe 'actions' do
    let(:ticket_model) { double(:Ticket) }
    let(:tickets) { double(:tickets) }
    let(:ticket) { double(:ticket) }
    let(:user) { double(:user) }
    let(:event) { double(:event) }

    before do
      allow(subject).to receive(:ticket_model).and_return(ticket_model)
    end

    describe '.ticket_for_event_for_user' do
      it 'returns the result from the the model' do
        allow(ticket_model).to receive_message_chain(:where, :joins, :where, :first).and_return(ticket)
        allow(tickets).to receive(:first).and_return(ticket)

        expect(subject.ticket_for_event_for_user(user, event)).to be(ticket)
      end
    end
  end
end
