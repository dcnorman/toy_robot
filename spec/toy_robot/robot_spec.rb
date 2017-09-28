require "spec_helper"

module ToyRobot
  class Location
    attr_reader :x
    attr_reader :y

    def initialize(x: 0, y: 0)
      @x = x
      @y = y
    end

    # @note There is no real need for a Table object given the current
    #   requirements, i.e. no need to support multiple Robots on the same
    #   table, no obstacles, etc. so this should suffice.
    def within_table_bounds?
      (0..5).cover?(x) && (0..5).cover?(y)
    end
  end

  class Robot
    attr_reader :location

    def place(new_location)
      if new_location.within_table_bounds?
        @location = new_location
      end
    end
  end

  RSpec.describe Robot do
    let(:robot) { Robot.new }

    describe "#location" do
      subject { robot.location }

      context "after being placed with #place" do
        before { robot.place(location) }

        context "given a location" do
          context "within table bounds" do
            let(:location) { Location.new }

            it { is_expected.to eq(location) }
          end

          context "out of table bounds" do
            let(:location) { Location.new(x: 7) }

            it { is_expected.to be_nil }
          end
        end
      end
    end
  end
end
