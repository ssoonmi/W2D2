require_relative 'piece'
require_relative 'null_piece'
require_relative 'cursor'
require_relative 'display'
require 'colorize'

class Board
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @grid = initialize_grid(player1.color, player2.color)
  end

  def initialize_grid(color1, color2)
    grid = Array.new(8) {[]}
    grid.map!.with_index do |row, row_idx|
      col_idx = 0
      if row_idx == 1
        8.times {|i| row << Pawn.new(color1, self, [row_idx, i - 1])}
      elsif row_idx == 6
        8.times {|i| row << Pawn.new(color2, self, [row_idx, i - 1])}
      elsif row_idx == 0
        row << Rook.new(color1, self, [row_idx, 0])
        row << Knight.new(color1, self, [row_idx, 1])
        row << Bishop.new(color1, self, [row_idx, 2])
        row << Queen.new(color1, self, [row_idx, 3])
        row << King.new(color1, self, [row_idx, 4])
        row << Bishop.new(color1, self, [row_idx, 5])
        row << Knight.new(color1, self, [row_idx, 6])
        row << Rook.new(color1, self, [row_idx, 7])
      elsif row_idx == 7
        row << Rook.new(color2, self, [row_idx, 0])
        row << Knight.new(color2, self, [row_idx, 1])
        row << Bishop.new(color2, self, [row_idx, 2])
        row << Queen.new(color2, self, [row_idx, 3])
        row << King.new(color2, self, [row_idx, 4])
        row << Bishop.new(color2, self, [row_idx, 5])
        row << Knight.new(color2, self, [row_idx, 6])
        row << Rook.new(color2, self, [row_idx, 7])
      else
        8.times {|i| row << NullPiece.instance}
      end
      row
    end
  end


  def move_piece(start_pos, end_pos)
    valid_move?(start_pos, end_pos)

    start_piece = self[start_pos]
    end_piece = self[end_pos]

    self[start_pos] = NullPiece.new
    self[end_pos] = start_piece
  end

  def valid_move?(start_pos, end_pos)
    start_piece = self[start_pos]
    end_piece = self[end_pos]
    raise 'Invalid start position' unless valid_position?(start_pos)
    raise 'Invalid end position' unless valid_position?(end_pos)
    raise 'Can\'t take own piece!' if is_same_player?(start_pos, end_pos)
    raise 'Can not take King!' if end_piece.type == 'King'
    raise 'No piece at start position' if start_piece.is_a?(NullPiece)
    #raise "Not a valid #{start_piece.type} move" unless start_piece.valid_move?(start_pos, end_pos)
    unless start_piece.type == 'Knight' || can_move_through?(start_pos, end_pos)
      raise "Cannot jump your pieces or enemy pieces with #{start_piece}"
    end
  end

  def can_move_through?(start_pos, end_pos)
    row1 = start_pos[0]
    row2 = end_pos[0]
    col1 = start_pos[1]
    col2 = end_pos[1]
    if row1 == row2
      valid_horizontal_move?(row1, col1, col2)
    elsif col1 == col2
      valid_vertical_move?(col1, row1, row2)
    else
      valid_diagonal_move?(start_pos, end_pos)
    end
  end

  def is_same_player?(start_pos, end_pos)
    self[start_pos].player == self[end_pos].player
  end

  def valid_horizontal_move?(row, col1, col2)
    col1, col2 = col2, col1 if col1 > col2
    (col1 + 1...col2).each do |i|
      return false unless self[[row, i]].is_a?(NullPiece)
    end
    true
  end

  def valid_vertical_move?(col, row1, row2)
    row1, row2 = row2, row1 if row1 > row2
    (row1 + 1...row2).each do |i|
      return false unless self[[i, col]].is_a?(NullPiece)
    end
    true
  end

  def valid_diagonal_move?(start_pos, end_pos)
    return false if start_pos[0] - end_pos[0] != start_pos[1] - end_pos[1]

    range_row = end_pos[0] - start_pos[0]
    delta_row = range_row / range_row.abs
    range_col = end_pos[1] - start_pos[1]
    delta_col = range_col / range_col.abs

    row = start_pos[0]
    col = start_pos[1]
    (range_row.abs - 1).times do |i|
      row += delta_row
      col += delta_col
      return false unless self[[row,col]].is_a?(NullPiece)
    end
    true
  end

  def valid_position?(pos)
    pos.all? {|dimension| dimension.between?(0,7)}
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    self.grid[row][col] = piece
  end

  def rows
    grid
  end

  attr_reader :player1, :player2

  protected

  attr_accessor :grid
end
