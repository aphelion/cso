class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :processor

      t.timestamps null: false
    end
    add_index :customers, :customer_id, unique: true
  end
end
