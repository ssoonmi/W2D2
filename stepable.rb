module Stepable

  def moves
    start_pos = self.pos
    valid_move_arr = []
    move_diffs.each do |dir|
      end_pos = [start_pos[0] + dir[0], start_pos[1] + dir[1]]
      if valid_position?(end_pos) && self.color != board[end_pos].color
        valid_move_arr << end_pos
      end
    end
    valid_move_arr
  end


end
