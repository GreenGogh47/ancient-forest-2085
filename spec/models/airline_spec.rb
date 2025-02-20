require 'rails_helper'

RSpec.describe Airline, type: :model do
  describe 'relationships' do
    it {should have_many :flights}
    it {should have_many(:passengers).through(:flights)}
  end

  describe 'instance methods' do
    before(:each) do
      @airline_1 = Airline.create!(name: "Southwest")
      @airline_2 = Airline.create!(name: "Delta") #Control

      @flight_1 = @airline_1.flights.create!(number: "47", date: "08/03/22", departure_city: "Moscow", arrival_city: "Paris")
      @flight_2 = @airline_1.flights.create!(number: "29", date: "05/06/22", departure_city: "Rome", arrival_city: "Jerusalem")
      @flight_3 = @airline_1.flights.create!(number: "369", date: "09/03/06", departure_city: "Somewhere", arrival_city: "Nowhere") #Control

      @passenger_1 = Passenger.create!(name: "Matthew", age: 25)
      @passenger_2 = Passenger.create!(name: "Mark", age: 26)
      @passenger_3 = Passenger.create!(name: "Luke", age: 27)

      @passenger_4 = Passenger.create!(name: "Rack", age: 5) #children
      @passenger_5 = Passenger.create!(name: "Shack", age: 8) #children
      @passenger_6 = Passenger.create!(name: "Benny", age: 14) #children

      @flight_1.passengers << @passenger_3

      @flight_2.passengers << @passenger_2
      @flight_2.passengers << @passenger_3

      @flight_3.passengers << @passenger_1
      @flight_3.passengers << @passenger_2
      @flight_3.passengers << @passenger_3

      @flight_1.passengers << @passenger_4
      @flight_1.passengers << @passenger_5
      @flight_1.passengers << @passenger_6
    end

    describe "distinct_adult_passengers" do
      it "can find distinct passengers THAT ARE 18 or ABOVE, in order of most flights taken" do
        expect(@airline_1.distinct_adult_passengers).to eq([@passenger_3, @passenger_2, @passenger_1])
      end
    end
  end
end
