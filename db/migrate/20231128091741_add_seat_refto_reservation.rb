class AddSeatReftoReservation < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :seat, foreign_key: true
    remove_column :reservations, :time
    remove_column :reservations, :seats
  end
end
