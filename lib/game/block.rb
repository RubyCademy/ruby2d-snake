# frozen_string_literals: true

class Game
  class Block
    attr_accessor :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def to_h
      {
        x: scaled_x,
        y: scaled_y,
        size: size,
        color: color
      }
    end

    def to_coords
      [scaled_x, scaled_y]
    end

    def ==(other_block)
      self.scaled_x == other_block.scaled_x && self.scaled_y == other_block.scaled_y
    end

    def scaled_x
      (self.x % GRID_WIDTH) * GRID_SIZE
    end

    def scaled_y
      (self.y % GRID_HEIGHT) * GRID_SIZE
    end

    protected

      def color
        'white'
      end

      def size
        GRID_SIZE - 1
      end
  end
end