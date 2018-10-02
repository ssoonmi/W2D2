require 'colorize'

class Piece

  attr_reader :color, :board
  attr_accessor :pos

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?

  end

  def valid_moves
  end

  def symbol
    ' '
  end

  def to_s
    self.symbol
  end

  def inspect
    self.symbol
  end

  def valid_position?(pos)
    self.board.valid_position?(pos)
  end

  private

  def move_into_check?(end_pos)
  end
end
