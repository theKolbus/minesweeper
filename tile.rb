class Tile

    def initialize(bomb = false)
        @bomb = bomb
        @reveled = false
        @flagged = false
        @neighbors = 0
    end

    attr_accessor :bomb, :reveled, :neighbors

    def set_mine
        @bomb = true
    end

    def print_tile

    end

end