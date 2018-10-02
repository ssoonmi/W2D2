require 'colorize'

class Piece

  attr_reader :color
  attr_accessor :pos, :board

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def empty?
    self.board[self.pos].is_a?(NullPiece)
  end

  def valid_moves
    moves.reject do |move|
      move_into_check?(move)
    end
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
    begin
      new_board = self.board.move_piece(color, self.pos, end_pos)
    rescue
      return true
    end
    false
  end
end
