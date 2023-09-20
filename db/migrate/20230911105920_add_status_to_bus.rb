class AddStatusToBus < ActiveRecord::Migration[7.0]
  def change
    add_column :buses, :status, :integer
    Bus.update_all(status: 0)
    change_column_default :buses, :status, nil
    remove_column :buses, :approved, :boolean
  end
end
