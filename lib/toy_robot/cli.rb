require "thor"

module ToyRobot
  class CLI < Thor
    package_name "toy_robot"

    map %w(-v --version) => :version
    desc "version", "Show version"
    def version
      require "toy_robot/version"
      say VERSION
    end

    desc "start", "Start Toy Robot Simulator"
    def start
      robot = Robot.new

      loop do
        case ask("Enter a command:")
        when /\APLACE (\d),(\d),(NORTH|EAST|SOUTH|WEST)\z/i
          robot.place(Location.new(x: $1.to_i, y: $2.to_i, facing: $3.downcase.to_sym))
        when /\A(MOVE|LEFT|RIGHT)\z/i
          robot.send($1.downcase)
        when /\AREPORT\z/i
          puts robot.report
        end
      end
    end
  end
end
