class Tile

    def initialize(bomb = false)
        @bomb = bomb
        @reveled = false
        @flagged = false
        @neighbor_mines = 0
        @neighbors = []
    end

    attr_accessor :bomb, :reveled, :flagged, :neighbor_mines, :neighbors

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

    def reveal
        return puts "Square is Flagged" if @flagged
        @reveled = true
        if @neighbor_mines == 0
            free_neighbors = @neighbors.select{|tile| !tile.reveled && !tile.bomb}
            free_neighbors.each{|tile| tile.reveal}
        end
    end

    def flag
        return puts "Already Flagged" if @flagged
        @flagged = !@flagged
    end

end