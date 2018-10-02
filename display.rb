require_relative 'board'

class Display

  attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)

  end

  def render(player_color)
    str = "  a b c d e f g h\n"
    @board.rows.each_with_index do |row, row_idx|
      str += "#{row_idx + 1} "
      row.each_with_index do |piece, col_idx|
        color = piece.color
        if [row_idx, col_idx] == @cursor.cursor_pos
          color = player_color == :green ? :blue : :yellow
          str += piece.is_a?(NullPiece) ? '_'.colorize(color) : piece.to_s.colorize(color)
        else
          str += piece.is_a?(NullPiece) ? ' ' : piece.to_s.colorize(color)
        end
        str += ' ' unless col_idx == 7
      end
      str += "\n"
    end
    puts str
  end

  def play
    until false
      render
      input = @cursor.get_input
      return input unless input.nil?
    end
  end

  def get_input(player_color)
    while true
      render(player_color)
      input = @cursor.get_input
      return input unless input.nil?
    end
  end
end
