class HumanPlayer < Player
  attr_accessor :display

  def initialize(color)
    @display = nil
    super
  end

  def make_move(display)
    input1 = display.get_input(self.color)
    input2 = display.get_input(self.color)
    [input1, input2]
  end
end
