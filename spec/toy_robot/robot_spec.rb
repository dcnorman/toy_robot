require "spec_helper"

module ToyRobot
  class Location
    NORTH = :north
    EAST  = :east
    SOUTH = :south
    WEST  = :west

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
      case facing
      when NORTH
        Location.new(x: x, y: y + 1, facing: facing)
      when EAST
        Location.new(x: x + 1, y: y, facing: facing)
      when SOUTH
        Location.new(x: x, y: y - 1, facing: facing)
      when WEST
        Location.new(x: x - 1, y: y, facing: facing)
      end
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

            context "facing EAST" do
              let(:location) { Location.new(facing: Location::EAST) }

              context "after being moved with #move once" do
                before { robot.move }

                it { is_expected.to eq(Location.new(x: 1, facing: Location::EAST)) }
              end

              context "after being moved with #move twice" do
                before { 2.times { robot.move } }

                it { is_expected.to eq(Location.new(x: 2, facing: Location::EAST)) }
              end

              context "after being moved with #move 10 times" do
                before { 10.times { robot.move } }

                it { is_expected.to eq(Location.new(x: 5, facing: Location::EAST)) }
              end
            end

            context "facing SOUTH" do
              let(:location) { Location.new(y: 5, facing: Location::SOUTH) }

              context "after being moved with #move once" do
                before { robot.move }

                it { is_expected.to eq(Location.new(y: 4, facing: Location::SOUTH)) }
              end

              context "after being moved with #move twice" do
                before { 2.times { robot.move } }

                it { is_expected.to eq(Location.new(y: 3, facing: Location::SOUTH)) }
              end

              context "after being moved with #move 10 times" do
                before { 10.times { robot.move } }

                it { is_expected.to eq(Location.new(y: 0, facing: Location::SOUTH)) }
              end
            end

            context "facing WEST" do
              let(:location) { Location.new(x: 5, facing: Location::WEST) }

              context "after being moved with #move once" do
                before { robot.move }

                it { is_expected.to eq(Location.new(x: 4, facing: Location::WEST)) }
              end

              context "after being moved with #move twice" do
                before { 2.times { robot.move } }

                it { is_expected.to eq(Location.new(x: 3, facing: Location::WEST)) }
              end

              context "after being moved with #move 10 times" do
                before { 10.times { robot.move } }

                it { is_expected.to eq(Location.new(x: 0, facing: Location::WEST)) }
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
