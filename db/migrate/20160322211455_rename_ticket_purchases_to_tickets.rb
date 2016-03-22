class RenameTicketPurchasesToTickets < ActiveRecord::Migration
  def change
    rename_table :ticket_purchases, :tickets
  end
end
