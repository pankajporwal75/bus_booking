class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer
    User.update_all(role: 0)
    change_column_default :users, :role, nil
    remove_column :users, :type
  end
end
