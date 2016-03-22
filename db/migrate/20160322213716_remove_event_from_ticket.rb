class RemoveEventFromTicket < ActiveRecord::Migration
  def change
    remove_column :tickets, :event_id
  end
end
