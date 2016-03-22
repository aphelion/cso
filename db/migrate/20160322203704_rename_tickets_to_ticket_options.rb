class RenameTicketsToTicketOptions < ActiveRecord::Migration
  def change
    rename_table :tickets, :ticket_options
    rename_column :ticket_purchases, :ticket_id, :ticket_option_id
  end
end
