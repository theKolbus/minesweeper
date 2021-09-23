require 'colorize'
require_relative 'tile'

class Board

    def initialize(size = 9, mines = 10)
        @size = size
        @mines = mines
        @board = []
        create_board(size, mines)
    end

    def create_board(size, mines)
        empty = (size * size) - mines
        values = Array.new(empty, false) + Array.new(mines, true)
        values.shuffle!
        board = []
        size.times {
            row = []
            size.times {row << Tile.new(values.pop)}
            board << row
        }
        @board = board
    end

    def print_board
        puts "  0 1 2 3 4 5 6 7 8"
        @board.each_with_index do |row, index|
            print index
            row.each do |tile|
                next print " *" if tile.bomb == true
                next print " /" if tile.reveled == false
                next print " F" if tile.flagged == true
                print tile.neighbors
            end
            puts
        end
        return
    end

end