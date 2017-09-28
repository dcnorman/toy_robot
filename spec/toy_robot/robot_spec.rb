require "spec_helper"

module ToyRobot
  class Location
    NORTH = :north

    attr_reader :x
    attr_reader :y
    attr_reader :facing

    def initialize(x: 0, y: 0, facing: NORTH)
      @x      = x
      @y      = y
      @facing = facing
    end

    # @note There is no real need for a Table object given the current
    #   requirements, i.e. no need to support multiple Robots on the same
    #   table, no obstacles, etc. so this should suffice.
    def within_table_bounds?
      (0..5).cover?(x) && (0..5).cover?(y)
    end

    def next
      Location.new(x: x, y: y + 1, facing: facing)
    end

    def ==(other_location)
      x == other_location.x && y == other_location.y && facing == other_location.facing
    end
  end

  class Robot
    attr_reader :location

    def place(new_location)
      if new_location.within_table_bounds?
        @location = new_location
      end
    end

    def move
      place(location.next)
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

            context "facing NORTH" do
              context "after being moved with #move once" do
                before { robot.move }

                it { is_expected.to eq(Location.new(y: 1)) }
              end

              context "after being moved with #move twice" do
                before { 2.times { robot.move } }

                it { is_expected.to eq(Location.new(y: 2)) }
              end

              context "after being moved with #move 10 times" do
                before { 10.times { robot.move } }

                it { is_expected.to eq(Location.new(y: 5)) }
              end
            end
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
