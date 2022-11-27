# frozen_string_literal: true

require "#{File.expand_path(File.dirname(__FILE__))}/../lib/game.rb"

set background: 'navy'

game = Game.new

set fps_cap: 20

update do
  clear
  game.draw
end

on :key_down do |event|
  if event.key == 'r'
    game = Game.new
  else
    game.set_snake_direction(event.key)
  end
end

show
