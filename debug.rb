require_relative 'lib/bowling_game'

def debug_game(rolls, description)
  game = BowlingGame.new
  puts "\n=== #{description} ==="

  rolls.each_with_index do |pins, index|
    game.roll(pins)
    puts "Jogada #{index + 1}: Rolou #{pins} pinos | Frame Atual: #{game.frames.map { |f| f.rolls }}"
    puts "Pontuação Parcial: #{game.score}"
    puts "-------------------------"
  end

  puts "Pontuação Final: #{game.score}"
  puts "===================================\n"
end

debug_game([10] * 12, "Jogo Perfeito (12 strikes)")

debug_game([0] * 20, "Gutter Game (todas as jogadas 0)")

debug_game([3, 6] * 10, "Jogo Normal (só números baixos)")

debug_game([5, 5] * 10 + [5], "Jogo com Apenas Spares (150 pontos)")

debug_game([1, 4, 4, 5, 6, 2, 7, 1, 3, 6, 4, 2, 5, 3, 6, 2, 4, 3, 2, 3], "Jogo Aleatório 2")

debug_game([10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9], "Jogo Aleatório 3")

debug_game([10, 3, 6, 7, 3, 10, 10, 2, 8, 6, 10, 10, 10, 5, 5, 10], "Jogo Aleatório 1")