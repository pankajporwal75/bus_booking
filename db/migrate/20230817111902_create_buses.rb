class CreateBuses < ActiveRecord::Migration[7.0]
  def change
    create_table :buses do |t|
      t.string :owner
      t.string :source
      t.string :destination
      t.string :bus_number
      t.date :journey_date
      t.time :depart_time

      t.timestamps
    end
  end
end
