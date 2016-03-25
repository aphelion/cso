class AddChargeToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :charge, index: true, foreign_key: true
  end
end
