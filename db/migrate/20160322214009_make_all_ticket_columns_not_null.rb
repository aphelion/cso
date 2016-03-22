class MakeAllTicketColumnsNotNull < ActiveRecord::Migration
  def change
    change_column_null :tickets, :user_id, false
    change_column_null :tickets, :ticket_option_id, false
  end
end
