describe Ticket do
  fixtures(:users, :events, :ticket_options)
  let(:user_1) { users(:young) }
  let(:user_2) { users(:mike) }
  let(:ticket_option_1) { ticket_options(:salsa_party_full_pass) }
  let(:ticket_option_2) { ticket_options(:salsa_party_vip_pass) }
  let(:event) { ticket_option.event }


  describe 'validation' do
    it 'allows different Users to have unique Tickets for a single Ticket Option' do
      first_ticket = Ticket.create(user: user_1, ticket_option: ticket_option_1)
      expect(first_ticket.persisted?).to be(true)

      second_ticket = Ticket.create(user: user_2, ticket_option: ticket_option_1)
      expect(second_ticket.persisted?).to be(true)
    end

    it 'allows different Users to have unique Tickets for a single Event' do
      first_ticket = Ticket.create(user: user_1, ticket_option: ticket_option_1)
      expect(first_ticket.persisted?).to be(true)

      second_ticket = Ticket.create(user: user_2, ticket_option: ticket_option_2)
      expect(second_ticket.persisted?).to be(true)
    end

    it 'only allows a User to have one Ticket for a single Ticket Option' do
      first_ticket = Ticket.create(user: user_1, ticket_option: ticket_option_1)
      expect(first_ticket.persisted?).to be(true)

      second_ticket = Ticket.create(user: user_1, ticket_option: ticket_option_1)
      expect(second_ticket.persisted?).to be(false)
    end

    it 'only allows a User to have one Ticket for a single Event' do
      first_ticket = Ticket.create(user: user_1, ticket_option: ticket_option_1)
      expect(first_ticket.persisted?).to be(true)

      second_ticket = Ticket.create(user: user_1, ticket_option: ticket_option_2)
      expect(second_ticket.persisted?).to be(false)
    end
  end
end
