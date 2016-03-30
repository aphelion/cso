class MigrateTicketsToEventPurchases < ActiveRecord::Migration
  def up
    TicketOption.find_each do |ticket_option|
      ticket_product = Product.create(
          name: ticket_option.name,
          price_cents: ticket_option.price_cents,
          price_currency: ticket_option.price_currency,
          created_at: ticket_option.created_at,
          updated_at: ticket_option.updated_at
      )

      event = ticket_option.event
      event.tickets << ticket_product


      Ticket.where(ticket_option: ticket_option).find_each do |ticket|
        ticket_purchase = ProductPurchase.create(
            charge_id: ticket.charge_id,
            product: ticket_product,
            created_at: ticket.created_at,
            updated_at: ticket.updated_at
        )

        EventPurchase.create(
            event: ticket.event,
            user: ticket.user,
            ticket_purchase: ticket_purchase,
            created_at: ticket.created_at,
            updated_at: ticket.updated_at
        )
      end
    end
  end
end
