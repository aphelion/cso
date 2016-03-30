class CreateJoinTableEventsTickets < ActiveRecord::Migration
  def change
    create_join_table :events, :products, {table_name: 'events_tickets'} do |t|
      t.index [:event_id, :product_id], unique: true
    end
  end
end
