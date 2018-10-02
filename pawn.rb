require_relative 'piece'

class Pawn < Piece

  def symbol
    'P'
  end

  def moves
    forward_steps + side_attacks
  end

  private

  def at_start_row?
    return true if self.color == board.player1.color && self.pos[0] == 1
    return true if self.color == board.player2.color && self.pos[0] == 6
    false
  end

  def forward_dir
    self.color == board.player1.color ? 1 : -1
  end

  def forward_steps
    dir = forward_dir
    start_pos = self.pos

    valid_moves = []
    valid_moves << [start_pos[0] + dir, start_pos[1]]
    if at_start_row?
      valid_moves << [start_pos[0] + (dir * 2), start_pos[1]]
    end

    valid_moves.select {|pos| board[pos].is_a?(NullPiece)}
  end

  def side_attacks
    row, col = self.pos
    dir = forward_dir

    [[row + dir, col + 1],[row + dir, col - 1]].select do |pos|
      valid_position?(pos) == true && self.color != board[pos].color &&
        board[pos].is_a?(NullPiece) == false
    end
  end

end
