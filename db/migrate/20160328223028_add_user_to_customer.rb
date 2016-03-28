class AddUserToCustomer < ActiveRecord::Migration
  def change
    add_reference :customers, :user, index: {:unique=>true}, foreign_key: true, null: false
  end
end
