require_relative 'roll'

class Frame
  attr_reader :rolls

  def initialize(last_frame = false)
    @rolls = []
    @is_last_frame = last_frame
  end

  def add_roll(pins)
    raise "Frame completo" if is_complete?

    if @is_last_frame
      @rolls << Roll.new(pins)
      return
    end

    if @rolls.empty? && pins == 10
      @rolls << Roll.new(10)
      return
    end

    if @rolls.length == 1
      max_possible = 10 - @rolls.first.pins
      pins = 0 if pins > max_possible
      pins = [pins, max_possible].min
    end
  
    @rolls << Roll.new(pins)
  end

  def is_complete?
    return @rolls.length == 3 if @is_last_frame
    return true if is_strike?
    @rolls.length == 2
  end

  def is_strike?
    @rolls.first&.strike?
  end

  def is_spare?
    @rolls.length == 2 && total_pins == 10
  end

  def total_pins
    @rolls.sum(&:pins)
  end

  def rolls_with_default
    return @rolls.map(&:pins) if @is_last_frame
    return @rolls.map(&:pins) if is_strike?
    @rolls.length == 1 ? [@rolls.first.pins, 0] : @rolls.map(&:pins)
  end
end
