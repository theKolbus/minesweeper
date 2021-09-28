require 'colorize'
require_relative 'tile'

class Board

    def initialize(size = 9, mines = 10)
        @size = size
        @mines = mines
        @board = []
        create_board(size, mines)
        give_neighbors
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

    def neighbors(start_row, start_col)
        neighbors = []
        neighbors << self[start_row - 1, start_col - 1] if valid_pos(start_row - 1, start_col - 1)
        neighbors << self[start_row - 1, start_col] if valid_pos(start_row - 1, start_col)
        neighbors << self[start_row - 1, start_col + 1] if valid_pos(start_row - 1, start_col + 1)
        neighbors << self[start_row, start_col - 1] if valid_pos(start_row, start_col - 1)
        neighbors << self[start_row, start_col + 1] if valid_pos(start_row, start_col + 1)
        neighbors << self[start_row + 1, start_col - 1] if valid_pos(start_row + 1, start_col - 1)
        neighbors << self[start_row + 1, start_col] if valid_pos(start_row + 1, start_col)
        neighbors << self[start_row + 1, start_col + 1] if valid_pos(start_row + 1, start_col + 1)
        neighbors
    end

    def give_neighbors
        @board.each_with_index do |row, index|
            row.each_with_index do |col, jndex|
                self[index,jndex].recieve_neighbors(self.neighbors(index,jndex))
            end
        end
        
    end

    def valid_pos(row,col)
        row.between?(0,@size - 1) && col.between?(0,@size - 1)
    end

    def [] (row,col)
        @board[row][col]
    end

    def print_board
        puts "  0 1 2 3 4 5 6 7 8"
        @board.each_with_index do |row, index|
            print index
            row.each do |tile|
                next print " F".magenta if tile.flagged == true
                next print " /" if tile.reveled == false
                next print " *".red if tile.bomb == true
                next print " -" if tile.neighbor_mines == 0
                next print " #{tile.neighbor_mines}".green if tile.neighbor_mines == 1
                next print " #{tile.neighbor_mines}".cyan if tile.neighbor_mines == 2
                next print " #{tile.neighbor_mines}".yellow if tile.neighbor_mines >= 3
            end
            puts
        end
        return
    end

    def flag(row,col)
        @board[row][col].flag
    end

    def reveal_tile(row,col)
        @board[row][col].reveal
    end

    def won?
        tiles  = @board.flatten
        non_mines = tiles.select{|tile| !tile.bomb}
        non_mines.all?{|tile| tile.reveled}
    end

    def lost?
        tiles  = @board.flatten
        mines = tiles.select{|tile| tile.bomb}
        mines.any?{|tile| tile.reveled}
    end


end