class Board
  attr_accessor :board

  def initialize
    @board = Array.new(9, ' ')
  end

  def board_template_show
    puts ' 1 | 2 | 3 '
    puts '-----------'
    puts ' 4 | 5 | 6 '
    puts '-----------'
    puts ' 7 | 8 | 9 '
  end

  def board_show
    showed_board = ' '
    @board.each_slice(3).with_index do |row, index|
      showed_board.concat(row.join(' | ') + "\n")
      showed_board.concat("-----------\n ") unless index == 2
    end
    showed_board
  end

  def board_update(position, symbol)
    @board[position - 1] = symbol
  end

  def move_checker(move)
    @board[move - 1] == ' '
  end

  def win_checker(symbol)
    win_combinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8],
      [0, 3, 6], [1, 4, 7], [2, 5, 8],
      [0, 4, 8], [2, 4, 6]
    ]
    win_combinations.any? do |combination|
      combination.all? { |position| @board[position] == symbol }
    end
  end
end
