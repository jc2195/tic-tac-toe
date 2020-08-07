# frozen_string_literal: true

# This is a class object for the game board
class Board
  def initialize(player_o, player_x)
    @player_o = player_o
    @player_x = player_x
    @board_map = { A1: '1', A2: '2', A3: '3', B1: '4', B2: '5', B3: '6', C1: '7', C2: '8', C3: '9' }
  end

  def show_board
    board = @board_map.to_a.sort_by{|square| square[0]}
    board.each_with_index do |item, index|
      if [2, 5, 8].include?(index)
        print "#{item[1]} \n"
      else
        print "#{item[1]} "
      end
    end
  end

  def add(player, location)
    value = if player == @player_o
              'O'
            else
              'X'
            end
    @board_map[@board_map.key(location)] = value
  end

  def check
    if [@board_map[:A1], @board_map[:A2], @board_map[:A3]].uniq.length == 1 then @board_map[:A1]
    elsif [@board_map[:B1], @board_map[:B2], @board_map[:B3]].uniq.length == 1 then @board_map[:B1]
    elsif [@board_map[:C1], @board_map[:C2], @board_map[:C3]].uniq.length == 1 then @board_map[:C1]
    elsif [@board_map[:A1], @board_map[:B1], @board_map[:C1]].uniq.length == 1 then @board_map[:A1]
    elsif [@board_map[:A2], @board_map[:B2], @board_map[:C2]].uniq.length == 1 then @board_map[:A2]
    elsif [@board_map[:A3], @board_map[:B3], @board_map[:C3]].uniq.length == 1 then @board_map[:A3]
    elsif [@board_map[:A1], @board_map[:B2], @board_map[:C3]].uniq.length == 1 then @board_map[:A1]
    elsif [@board_map[:A3], @board_map[:B2], @board_map[:C1]].uniq.length == 1 then @board_map[:A3]
    else; false; end
  end
end

def game(player_o, player_x)
  game_board = Board.new(player_o, player_x)
  prng = Random.new.rand(2)
  current_player = prng.zero? ? player_o : player_x
  while game_board.check == false
    game_board.show_board
    puts "#{current_player}, where do you want to place?"
    print 'Position: '
    position = nil
    loop do
      position = gets.chomp
      break if position.to_i.between?(1, 9)

      print 'Please enter a valid position:'
    end
    game_board.add(current_player, position)
    current_player = current_player == player_o ? player_x : player_o
  end
  winner = current_player == player_o ? player_x : player_o
  puts "#{winner} is the winner!"
end

print "Who wants to play as noughts?\nName: "
player_o = gets.chomp
print "Who wants to play as crosses?\nName: "
player_x = gets.chomp
puts "Let's play!"
game(player_o, player_x)
