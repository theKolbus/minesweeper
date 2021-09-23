require 'colorize'
require_relative 'tile'

class Board

    def initialize(size = 9, mines = 10)
        @board = Array.new(size) { Array.new(size) {Tile.new} }
    end
    
    def get_random_tile
        indeexes = @board.length
        row = rand(indeexes)
        col = rand(indeexes)
        @board[row][col]
    end

    def lay_mines(mines = 10)
        mines_left = mines

        until mines_left == 0
            tile = get_random_tile
            if tile.bomb == false
                tile.set_mine
                mines_left -= 1
            end
            puts "mines left: #{mines_left}"
        end

    end

end