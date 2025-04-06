require_relative 'lib/game'

game_type = Game.input_game_type
players = Game.create_players(game_type)

game = Game.create(game_type, players)

game.start_game
