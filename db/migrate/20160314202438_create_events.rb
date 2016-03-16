class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :event_start
      t.datetime :event_end
      t.datetime :sale_start
      t.datetime :sale_end
    end
  end
end
