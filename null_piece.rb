require_relative 'piece'
require 'singleton'

class NullPiece < Piece
  include Singleton

  def initialize
    super(nil, nil, nil)
  end

  def moves
    []
  end

  def symbol
    ' '
  end

end
