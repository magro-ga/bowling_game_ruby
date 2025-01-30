require_relative 'frame'
require_relative 'score_calculator'

class BowlingGame
  attr_reader :frames

  def initialize
    @frames = Array.new(9) { Frame.new } + [Frame.new(last_frame: true)]
    @current_frame = 0
  end

  def roll(pins)
    raise 'Game is over' if game_over?

    frame = current_frame
    frame.add_roll(pins)
  
    advance_frame if frame.is_complete? && !last_frame?
  end

  def score
    ScoreCalculator.new(frames).calculate
  end

  private

  def current_frame
    frames[@current_frame]
  end

  def advance_frame
    @current_frame += 1
  end

  def game_over?
    return false unless last_frame?

    rolls = current_frame.rolls.size
    final_frame_complete = rolls == 3 || (!current_frame.is_strike? && !current_frame.is_spare? && current_frame.is_complete?)

    final_frame_complete
  end

  def last_frame?
    @current_frame == 9
  end
end
