class DropTableTicketOptions < ActiveRecord::Migration
  def change
    drop_table :ticket_options
  end
end
