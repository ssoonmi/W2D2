module Slideable

  HORIZONTAL_DIRS = [[0,1],[0,-1],[1,0],[-1,0]]
  DIAGONAL_DIRS = [[1,1],[1,-1],[-1,1],[-1,-1]]

  def moves
    all_valid_moves = []
    dirs = move_dirs
    dirs.each do |dir|
      if dir == :horizontal
        all_valid_moves += horizontal_dirs
      else
        all_valid_moves += diagonal_dirs
      end
    end
    all_valid_moves
  end

  def horizontal_dirs
    start_pos = self.pos
    valid_move_arr = []
    HORIZONTAL_DIRS.each do |dir|
      end_pos = [start_pos[0] + dir[0], start_pos[1] + dir[1]]
      while valid_position?(end_pos)
        break if self.color == board[end_pos].color
        valid_move_arr << end_pos
        break unless board[end_pos].is_a?(NullPiece)
        end_pos = [end_pos[0] + dir[0], end_pos[1] + dir[1]]
      end
    end
    valid_move_arr
  end

  def diagonal_dirs
    start_pos = self.pos
    valid_move_arr = []
    DIAGONAL_DIRS.each do |dir|
      end_pos = [start_pos[0] + dir[0], start_pos[1] + dir[1]]
      while valid_position?(end_pos)
        break if self.color == board[end_pos].color
        valid_move_arr << end_pos
        break unless board[end_pos].is_a?(NullPiece)
        end_pos = [end_pos[0] + dir[0], end_pos[1] + dir[1]]
      end
    end
    valid_move_arr
  end

end
