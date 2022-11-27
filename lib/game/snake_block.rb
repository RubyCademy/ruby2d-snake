# frozen_string_literals: true

class Game
  class SnakeBlock < Block
    attr_accessor :head

    def initialize(x, y, head = false)
      super(x, y)

      @head = head
    end

    private

      def color
        self.head ? 'red' : super
      end
  end
end