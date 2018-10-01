require_relative 'board'

class Display

  attr_reader :cursor, :board

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)

  end

  def render
    str = "  0 1 2 3 4 5 6 7\n"
    @board.rows.each_with_index do |row, row_idx|
      str += "#{row_idx} "
      row.each_with_index do |piece, col_idx|
        color = (piece.player == @board.player1 ? :green : :red)
        if [row_idx, col_idx] == @cursor.cursor_pos
          color = :blue
          str += piece.type.nil? ? '_'.colorize(color) : piece.type[0].colorize(color)
        else
          str += piece.type.nil? ? ' ' : piece.type[0].colorize(color)
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
end
