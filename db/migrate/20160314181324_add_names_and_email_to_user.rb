class AddNamesAndEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string, null: false, default: ''
    add_column :users, :last_name, :string, null: false, default: ''
    add_column :users, :email, :string, null: false, default: ''

    add_index :users, :email, unique: true
  end
end
