class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name, null: false
      t.belongs_to :event, null: false, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
