class AddApprovedToBus < ActiveRecord::Migration[7.0]
  def change
    add_column :buses, :approved, :boolean
  end
end
