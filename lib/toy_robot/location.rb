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

    def rotate(degrees)
      Location.new(x: x, y: y, facing: directions.rotate(directions.index(facing))[degrees / 90])
    end

    def to_s
      [x, y, facing.to_s.upcase].join(",")
    end

    def ==(other_location)
      x == other_location.x && y == other_location.y && facing == other_location.facing
    end

    private

    def directions
      [NORTH, EAST, SOUTH, WEST]
    end
  end
end
