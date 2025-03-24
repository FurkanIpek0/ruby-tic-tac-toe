require_relative 'game/question'
require_relative 'game/player'
require_relative 'game/board'


class Game
  include Question

  def initialize(game_type, players)
    @game_type = game_type
    @players = players
    @board = Board.new
  end

  def self.create_game
    @players = []
    game_type = Question.question_ask("Select game type: Player vs Player (pp), Computer vs Computer (cc), Player vs Computer (pc) ", "pp", "cc", "pc")
    case game_type
    when "pp"
      player1_name = Question.question_type_ask("Enter Player 1 name: ", "name")
      player2_name = Question.question_type_ask("Enter Player 2 name: ", "name")
      @players = Player.new(player1_name, "X", "Player"), Player.new(player2_name, "O", "Player")
      Game.new(game_type, @players)
    when "cc"
      @players = Player.new("Computer 1", "X", "Computer"), Player.new("Computer 2", "O", "Computer")
      Game.new(game_type, @players)
    when "pc"
      player_name = Question.question_type_ask("Enter Player name: ", "name")
      @players = Player.new(player_name, "X", "Computer"), Player.new("Computer", "O", "Computer")
      Game.new(game_type, @players)
    else
      puts "Invalid input. Please try"
    end
  end

  def start_game
    puts "Game started"
    current_player_index = 0
    current_player = @players[0]
    
    @board.board_template_show

    loop do
      if current_player_index == 0 
        current_player = @players[0]
        current_player_index = 1
      else
        current_player = @players[1]
        current_player_index = 0
      end
      turn(current_player)
      puts @board.board_show
    end
  end

  def turn(player)
    unless @board.board.include?(" ")
      puts "It's a draw!"
      exit
    end
    puts player.name
    puts player.symbol
    if player.type == "Computer"
      answer = @board.board.map.with_index { |cell, index| [cell, index + 1] }.select { |cell, index| cell == " "}.sample[1]
      @board.board_update(answer, player.symbol)
      puts answer
    elsif player.type == "Player"
      playable_moves = @board.board.map.with_index { |cell, index| [cell, index + 1] }.select { |cell, index| cell == " "}.map { |cell, index| index}
      p playable_moves
      answer = Question.question_ask("Enter your move: ", *playable_moves)

      if @board.move_checker(answer.to_i)
        @board.board_update(answer.to_i, player.symbol)
      end
    end
    if @board.win_checker(player.symbol)
      puts "#{player.name} wins!"
      puts @board.board_show
      exit
    end
  end
end

