module Pattern
  def straight_coords(x, y, map_length)
    straight_x_coords = (-(map_length - 1)..(map_length - 1)).map { |i| [x + i, y] }
    straight_y_coords = (-(map_length - 1)..(map_length - 1)).map { |i| [x, y + i] }
    [straight_x_coords] + [straight_y_coords]
  end

  def cross_coords(x, y, map_length)
    cross_x_coords = (-(map_length - 1)..(map_length - 1)).map { |i| [x + i, y + i] }
    cross_y_coords = (-(map_length - 1)..(map_length - 1)).map { |i| [x + i, y - i] }
    [cross_x_coords] + [cross_y_coords]
  end

  def filter_outer_coords(coords, map_length)
    map_coords = []
    (0..map_length - 1).each do |i|
      (0..map_length - 1).each do |j|
        map_coords.push([i, j])
      end
    end
    coords.map { |inside_coords| inside_coords.select { |coord| map_coords.include?(coord) } }
  end

  def get_dot_coords(block, board)
    dot_coords = []
    board.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        dot_coords.push([i, j]) if cell == block[:player_type]
      end
    end
    dot_coords
  end

  def coords_comparison(coords, dot_coords)
    coords.any? do |coord|
      coord.all? { |c| dot_coords.include?(c) }
    end
  end
end
