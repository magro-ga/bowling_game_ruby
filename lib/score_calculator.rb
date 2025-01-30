require 'logger'

class ScoreCalculator
    def initialize(frames)
      @frames = frames
      @logger = Logger.new(STDOUT)
    end

    def calculate
      total_score = 0

      @frames.each_with_index do |frame, index|
        frame_score = frame.total_pins
        frame_score += strike_bonus(index) if frame.is_strike? && index < 9
        frame_score += spare_bonus(index) if frame.is_spare? && index < 9
        total_score += frame_score
  
        @logger.info("Frame #{index + 1}: Rolls=#{frame.rolls_with_default.inspect}, Score=#{total_score}")
      end

      total_score
    end

    private

    def strike_bonus(index)
        next_frame = @frames[index + 1]
        return 0 unless next_frame

        if index == 9
          return next_frame.rolls.sum
        end

        bonus_rolls = next_frame.rolls_with_default.dup
        if next_frame.is_strike? && index < 8
          second_frame = @frames[index + 2]
          bonus_rolls += second_frame.rolls_with_default if second_frame
        end

        bonus_rolls.first(2).sum
    end

    def spare_bonus(index)
      next_frame = @frames[index + 1]
      return 0 unless next_frame

      next_frame.rolls_with_default.first.to_i
    end
  end
  