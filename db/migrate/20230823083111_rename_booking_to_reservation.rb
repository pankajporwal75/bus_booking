class RenameBookingToReservation < ActiveRecord::Migration[7.0]
  def change
    rename_table :bookings, :reservations
  end
end
