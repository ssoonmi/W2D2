require_relative 'piece'
require_relative 'stepable'

class Knight < Piece
  include Stepable

  def symbol
    'N'
  end

end
