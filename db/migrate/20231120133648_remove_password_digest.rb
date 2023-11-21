class RemovePasswordDigest < ActiveRecord::Migration[7.0]
  def up
    # Remove the password_digest column
    remove_column :users, :password_digest
  end

  def down
    # Add the password_digest column back with the same data type and options
    add_column :users, :password_digest, :string, null: false, default: ""
  end
end
