# frozen_string_literal: true

require 'ruby2d'

lib_path = File.expand_path File.dirname(__FILE__)
require "#{lib_path}/game/block"
require "#{lib_path}/game/food_block"
require "#{lib_path}/game/snake_block"
require "#{lib_path}/game/snake"

# width  = 640 / GRID_SIZE = 32
# height = 480 / GRID_SIZE = 24

class Game
  GRID_SIZE   = 20                        # size of a unit in the grid
  GRID_WIDTH  = Window.width / GRID_SIZE  # 640 / 20 = 32
  GRID_HEIGHT = Window.height / GRID_SIZE # 480 / 20 = 24

  VERTICAL_DIRECTIONS   = %w[up down].freeze
  HORIZONTAL_DIRECTIONS = %w[left right].freeze
  DIRECTIONS = (VERTICAL_DIRECTIONS + HORIZONTAL_DIRECTIONS).freeze

  def initialize
    @snake = Snake.new
    @score = 0

    spawn_food
  end

  def draw
    if @snake.eating?(@food)
      spawn_food
      update_score
    end

    if @snake.hit_itself?
      draw_finish_message
    else
      @snake.move
      draw_food
      draw_score
    end

    @snake.draw
  end

  def set_snake_direction(new_direction)
    @snake.direction = new_direction if authorized_direction?(new_direction)
  end

  private

    def authorized_direction?(direction)
      DIRECTIONS.include?(direction) && @snake.can_change_direction?(direction)
    end

    def update_score
      @score += 1
    end

    def draw_score
      Text.new("Score: #{@score}", x: 10, y: 10, size: 25)
    end

    def draw_finish_message
      Text.new("Game over, your score was #{@score}. Press 'R' to restart.", x: 10, y: 10, size: 25, color: 'red')
    end

    def spawn_food
      @food = FoodBlock.new(rand(GRID_WIDTH), rand(GRID_HEIGHT))
    end

    def draw_food
      Square.new(@food.to_h)
    end

    def respawn_food
      spawn_food
      draw_food
    end
end