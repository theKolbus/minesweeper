require_relative 'board'

class Game

    def initialize
        @board = Board.new
    end

    def get_guess
        puts "Please enter a square to sweep ie 4,2".yellow
        guess = gets.chomp
        until guess.match?(/^(?:[Ff][, ])?\d+[, ]+\d+$/)
            puts "Not a valid space"
            get_guess
        end
        guess
    end

    def take_turn
        puts
        @board.print_board
        puts
        guess = get_guess.split(/[, ]/)
        return @board.flag(guess[1].to_i, guess[2].to_i) if guess[0].match?(/[Ff]/)
        @board.reveal_tile(guess[0].to_i, guess[1].to_i)
    end

    def play
        take_turn until @board.won? || @board.lost?
        @board.print_board
        puts "Congratulation You Won".light_magenta if @board.won?
        puts "Sorry Try Again".red if @board.lost?
    end

end

game = Game.new