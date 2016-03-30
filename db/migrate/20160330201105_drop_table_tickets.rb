class DropTableTickets < ActiveRecord::Migration
  def change
    drop_table :tickets
  end
end
