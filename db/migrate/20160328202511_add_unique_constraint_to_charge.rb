class AddUniqueConstraintToCharge < ActiveRecord::Migration
  def change
    add_index :charges, :charge_id, unique: true
  end
end
