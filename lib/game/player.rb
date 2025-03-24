class Player
  attr_reader :name, :symbol, :type

  def initialize(name, symbol, type)
    @name = name
    @symbol = symbol
    @type = type
  end
end
