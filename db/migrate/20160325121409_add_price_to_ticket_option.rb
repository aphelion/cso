class AddPriceToTicketOption < ActiveRecord::Migration
  def change
    add_monetize :ticket_options, :price
  end
end
