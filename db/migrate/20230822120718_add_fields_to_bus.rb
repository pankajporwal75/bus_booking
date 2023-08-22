class AddFieldsToBus < ActiveRecord::Migration[7.0]
  def change
    add_column :buses, :capacity, :integer
    add_reference :buses, :bus_owner, null: false, foreign_key: {to_table: :users}
    remove_column :buses, :owner
  end
end
