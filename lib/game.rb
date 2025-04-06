require_relative 'game/player'
require_relative 'game/board'

# The Game class handles the main logic for the Tic-Tac-Toe game.
# It manages the board, players, and game flow, including turns and win conditions.
class Game
  def initialize(board, players, current_player, moves, game_type)
    @board = board
    @players = players
    @current_player = current_player
    @moves = moves
    @game_type = game_type
  end

  def self.create(game_type, players)
    board = Board.create(3, 3)
    current_player = players[0]
    moves = []
    Game.new(board, players, current_player, moves, game_type)
  end

  def start_game
    loop do
      loop do
        puts @board.show
        puts "#{@current_player.name}'s turn (#{@current_player.symbol}) \n"
        coordinates = if @current_player.type == 'player'
                        @current_player.player_move(@board.available_moves)
                      else
                        @current_player.computer_move(@board.available_moves)
                      end
        block = { coords: coordinates, player_type: @current_player.symbol }
        @board.update(coordinates, @current_player.symbol)
        @moves.push({ round: @moves.length + 1, player: @current_player.name, coordinates: coordinates })
        if @board.control_win_patterns(block)
          puts @board.show
          puts "#{@current_player.name} wins!"
          @current_player.score += 1
          break
        elsif @board.available_moves.empty?
          puts @board.show
          puts 'It\'s a draw!'
          break
        else
          @current_player = @current_player.switch_player(@players)
        end
      end
      @players.each do |player|
        puts "#{player.name}: #{player.score}"
        if player.score == 100
          puts "#{player.name} is big winner !!!!!!!!!!!"
          return player
        end
      end
      @board = Board.create(3, 3)
    end
  end

  def self.input_game_type
    loop do
      puts 'Enter game type: pp,pc,cc'
      game_type = gets.chomp.downcase
      return game_type if %w[pp pc cc].include?(game_type)

      puts 'Invalid game type. Please enter pp, pc, or cc.'
    end
  end

  def self.create_players(game_type)
    case game_type
    when 'pp'
      [Player.create(Player.name_input, 'player', 'X'), Player.create(Player.name_input, 'player', 'O')]
    when 'pc'
      [Player.create(Player.name_input, 'player', 'X'), Player.create('Computer1', 'computer', 'O')]
    when 'cc'
      [Player.create('Computer1', 'computer', 'X'), Player.create('Computer2', 'computer', 'O')]
    end
  end
end
