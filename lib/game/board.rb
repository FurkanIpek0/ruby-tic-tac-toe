require_relative 'board/pattern'

class Board
  include Pattern

  def initialize(board)
    @board = board
  end

  def self.create(rows, columns)
    board = Array.new(rows) { Array.new(columns) }
    Board.new(board)
  end

  def show
    board_template = ''
    @board.each.with_index do |row, row_index|
      row.each.with_index do |cell, column_index|
        board_template += if cell.nil?
                            '   '
                          else
                            " #{cell} "
                          end
        board_template += '|' unless column_index == row.length - 1
      end
      board_template += "\n"
      board_template += '---+' * @board.first.length unless row_index == @board.length - 1
      board_template += "\n"
    end
    board_template
  end

  def update(coordinates, symbol)
    x, y = coordinates
    @board[x][y] = symbol
  end

  def control_win_patterns(block = 0)
    output = { win_status: true, player_type: 'X' }
    map_length = @board.length
    x, y = block[:coords]
    coords = cross_coords(x, y, map_length) + straight_coords(x, y, map_length)
    inside_win_coords = filter_outer_coords(coords, map_length).select do |coords_arr|
      coords_arr.length == @board.length
    end
    dot_coords = get_dot_coords(block, @board)
    coords_comparison(inside_win_coords, dot_coords)
  end

  def available_moves
    available_moves = []
    @board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        available_moves.push([i, j]) if cell.nil?
      end
    end
    available_moves
  end
end
