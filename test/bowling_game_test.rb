require 'minitest/autorun'
require_relative '../lib/bowling_game'

class BowlingGameTest < Minitest::Test
  def setup
    @game = BowlingGame.new
  end

  def test_gutter_game
    20.times { @game.roll(0) }
    assert_equal 0, @game.score
  end

  def test_all_ones
    20.times { @game.roll(1) }
    assert_equal 20, @game.score
  end

  def test_perfect_game
    12.times { @game.roll(10) }
    assert_equal 300, @game.score
  end

  def test_spare
    @game.roll(5)
    @game.roll(5)
    @game.roll(3)
    17.times { @game.roll(0) }
    assert_equal 16, @game.score
  end

  def test_strike
    @game.roll(10)
    @game.roll(3)
    @game.roll(4)
    16.times { @game.roll(0) }
    assert_equal 24, @game.score
  end

  def test_alternating_strikes_and_spares
    @game.roll(10)
    @game.roll(5)
    @game.roll(5)
    @game.roll(7)
    @game.roll(2)
    14.times { @game.roll(0) }
    assert_equal 46, @game.score
  end

  def test_no_strikes_or_spares
    rolls = [1, 4, 4, 5, 6, 2, 7, 1, 3, 6, 4, 2, 5, 3, 6, 2, 4, 3, 2, 3]
    rolls.each { |pins| @game.roll(pins) }
    assert_equal 73, @game.score
  end

  def test_last_frame_spare
    18.times { @game.roll(0) }
    @game.roll(5)
    @game.roll(5)
    @game.roll(7)
    assert_equal 17, @game.score
  end

  def test_last_frame_strike
    18.times { @game.roll(0) }
    @game.roll(10)
    @game.roll(7)
    @game.roll(2)
    assert_equal 19, @game.score
  end

  def test_all_strikes_except_last_frame
    10.times { @game.roll(10) }
    @game.roll(10)
    @game.roll(9)
    assert_equal 299, @game.score
  end

  def test_spare_followed_by_strike
    @game.roll(5)
    @game.roll(5)
    @game.roll(10)
    @game.roll(4)
    @game.roll(3)
    14.times { @game.roll(0) }
    assert_equal 44, @game.score
  end

  def test_all_zeros_until_last_frame
    18.times { @game.roll(0) }
    @game.roll(10)
    @game.roll(10)
    @game.roll(10)
    assert_equal 30, @game.score
  end  
end
