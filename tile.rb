class Tile

    def initialize(bomb = false)
        @bomb = bomb
        @reveled = false
        @flagged = false
        @neighbor_mines = 0
        @neighbors = []
    end

    attr_accessor :bomb, :reveled, :neighbor_mines, :neighbors

    def set_mine
        @bomb = true
    end

    def set_neighbor_bombs
        bombs = 0
        @neighbors.each { |neighbor| bombs += 1 if neighbor.bomb == true }
        @neighbor_mines = bombs
    end

    def recieve_neighbors(neighbors)
        @neighbors = neighbors
        set_neighbor_bombs
    end

end