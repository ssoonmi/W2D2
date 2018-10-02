require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
  include Slideable

  def symbol
    'Q'
  end

  def move_dirs
    [:horizontal, :diagonal]
  end

end
