require_relative 'board'
require_relative 'human_player'


class Chess
  attr_accessor :display, :board, :current_player
  attr_reader :player1, :player2

  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
    @board = Board.new(player1,player2)
    @display = Display.new(@board)
    player1.display = @display
    player2.display = @display
    @current_player = @player1
  end

  def play
    until checkmate?
      begin
        input1, input2 = self.current_player.make_move(self.display)
        self.board.move_piece!(self.current_player.color, input1, input2)
      rescue
        retry
      end
      switch_players
    end
    puts "#{switch_players.color.to_s.capitalize} won!"
  end

  def checkmate?
    color1, color2 = self.player1.color, self.player2.color
    self.board.checkmate?(color1) || self.board.checkmate?(color2)
  end

  def switch_players
    self.current_player = self.current_player == self.player1 ? self.player2 : self.player1
  end
end

if __FILE__ == $PROGRAM_NAME
  p1 = HumanPlayer.new(:green)
  p2 = HumanPlayer.new(:red)
  game = Chess.new(p1, p2)
  game.play
end
