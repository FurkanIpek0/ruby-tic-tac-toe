class Player
  attr_reader :name, :symbol, :type
  attr_accessor :score

  def initialize(name, score, type, symbol)
    @name = name
    @score = score
    @symbol = symbol
    @type = type
  end

  def self.create(name, type, symbol)
    score = 0
    Player.new(name, score, type, symbol)
  end

  def player_move(available_moves)
    loop do
      puts 'Enter coordinates (row and column) separated by a space:'
      input = gets.chomp
      coordinates = input.split.map(&:to_i)
      return coordinates if available_moves.include?(coordinates)

      puts 'Invalid coordinates. Please enter two numbers separated by a space.'
    end
  end

  def computer_move(available_moves)
    available_moves.sample
  end

  def self.name_input
    loop do
      puts 'Enter player name:'
      name = gets.chomp
      return name if name.match?(/\A[a-zA-Z0-9]{3,15}\z/)

      puts 'Invalid name. Please enter a name with 3 to 15 alphanumeric characters.'
    end
  end

  def switch_player(players)
    @symbol == players[0].symbol ? players[1] : players[0]
  end
end
