module ToyRobot
  class Robot
    attr_reader :location

    def place(new_location)
      if new_location&.within_table_bounds?
        @location = new_location
      end
    end

    def move
      place(location&.next)
    end

    def left
      place(location&.rotate(-90))
    end

    def right
      place(location&.rotate(90))
    end

    def report
      location.to_s
    end
  end
end
