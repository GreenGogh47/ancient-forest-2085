class CreatePassengerFlights < ActiveRecord::Migration[5.2]
  def change
    create_table :passenger_flights do |t|
      t.belongs_to :passenger, foreign_key: true
      t.belongs_to :flight, foreign_key: true

      t.timestamps
    end
  end
end
