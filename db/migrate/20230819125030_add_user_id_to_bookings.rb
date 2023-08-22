class AddUserIdToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :user_id, :integer, index: true, foreign_key: true
  end
end
