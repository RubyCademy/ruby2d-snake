# frozen_string_literals: true

class Game
  class FoodBlock < Block
    private

      def color
        'yellow'
      end

      def size
        GRID_SIZE
      end
  end
end