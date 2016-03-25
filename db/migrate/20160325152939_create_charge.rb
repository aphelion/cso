class CreateCharge < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.string :charge_id
      t.string :processor
    end
  end
end
