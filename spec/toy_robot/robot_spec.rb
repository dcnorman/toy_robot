require "spec_helper"

module ToyRobot
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

              context "after being rotated left with #left" do
                before { robot.left }

                it { is_expected.to eq(Location.new(facing: Location::WEST)) }
              end

              context "after being rotated right with #right" do
                before { robot.right }

                it { is_expected.to eq(Location.new(facing: Location::EAST)) }
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

              context "after being rotated left with #left" do
                before { robot.left }

                it { is_expected.to eq(Location.new(facing: Location::NORTH)) }
              end

              context "after being rotated right with #right" do
                before { robot.right }

                it { is_expected.to eq(Location.new(facing: Location::SOUTH)) }
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

              context "after being rotated left with #left" do
                before { robot.left }

                it { is_expected.to eq(Location.new(y: 5, facing: Location::EAST)) }
              end

              context "after being rotated right with #right" do
                before { robot.right }

                it { is_expected.to eq(Location.new(y: 5, facing: Location::WEST)) }
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

              context "after being rotated left with #left" do
                before { robot.left }

                it { is_expected.to eq(Location.new(x: 5, facing: Location::SOUTH)) }
              end

              context "after being rotated right with #right" do
                before { robot.right }

                it { is_expected.to eq(Location.new(x: 5, facing: Location::NORTH)) }
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

    describe "#report" do
      subject { robot.report }

      context "after being placed with #place" do
        before { robot.place(location) }

        context "given a location" do
          context "within table bounds" do
            context "facing NORTH" do
              let(:location) { Location.new }

              it { is_expected.to eq("0,0,NORTH") }
            end

            context "facing EAST" do
              let(:location) { Location.new(x: 1, y: 1, facing: Location::EAST) }

              it { is_expected.to eq("1,1,EAST") }
            end

            context "facing SOUTH" do
              let(:location) { Location.new(x: 1, y: 3, facing: Location::SOUTH) }

              it { is_expected.to eq("1,3,SOUTH") }
            end

            context "facing WEST" do
              let(:location) { Location.new(x: 1, y: 5, facing: Location::WEST) }

              it { is_expected.to eq("1,5,WEST") }
            end
          end

          context "out of table bounds" do
            let(:location) { Location.new(x: 7) }

            it { is_expected.to be_empty }
          end
        end
      end
    end
  end
end
