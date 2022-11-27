# frozen_string_literal: true

class Game
  class Snake
    attr_writer :direction

    def initialize
      @positions = [
        SnakeBlock.new(2, 0),
        SnakeBlock.new(2, 1),
        SnakeBlock.new(2, 2),
        SnakeBlock.new(2, 3, true)
      ]

      @direction = 'down'
      @eating = false
    end

    def move
      unless @eating
        @positions.shift
        @eating = false
      end

      head.head = false

      case @direction
      when 'up'    then @positions.push(SnakeBlock.new(head.x, head.y - 1, true))
      when 'down'  then @positions.push(SnakeBlock.new(head.x, head.y + 1, true))
      when 'left'  then @positions.push(SnakeBlock.new(head.x - 1, head.y, true))
      when 'right' then @positions.push(SnakeBlock.new(head.x + 1, head.y, true))
      end
    end

    def draw
      @positions.each { |position| Square.new(position.to_h) }
    end

    def eating?(food)
      @eating = (head == food)
    end

    # checks if there is 2 snake block at the exact same position
    def hit_itself?
      coords = snake_blocks_coords

      coords.uniq.size != coords.size
    end

    def can_change_direction?(new_direction)
      (VERTICAL_DIRECTIONS.include?(@direction) && VERTICAL_DIRECTIONS.none?(new_direction)) ||
        (HORIZONTAL_DIRECTIONS.include?(@direction) && HORIZONTAL_DIRECTIONS.none?(new_direction))
    end


    def snake_blocks_coords
      @positions.map(&:to_coords)
    end

    def size
      @positions.size
    end

    private

      def head
        @positions.last
      end
  end
end