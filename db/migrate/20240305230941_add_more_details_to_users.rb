class AddMoreDetailsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :firstname, :string, null: false
    add_column :users, :lastname, :string, null: false
    add_column :users, :admin, :boolean, default: false, null: false
  end
end
