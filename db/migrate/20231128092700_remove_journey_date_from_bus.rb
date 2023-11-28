class RemoveJourneyDateFromBus < ActiveRecord::Migration[7.0]
  def change
    remove_column :buses, :journey_date, :string
  end
end
