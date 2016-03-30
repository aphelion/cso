class CreateJoinTableEventsAddons < ActiveRecord::Migration
  def change
    create_join_table :events, :products, {table_name: 'events_addons'} do |t|
      t.index [:event_id, :product_id], unique: true
    end
  end
end
