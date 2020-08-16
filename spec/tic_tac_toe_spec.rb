class Board
  attr_accessor :board_map
  def initialize(
    player_o,
    player_x,
    board_map = { A1: '1', A2: '2', A3: '3', B1: '4', B2: '5', B3: '6', C1: '7', C2: '8', C3: '9' }
  )
    @player_o = player_o
    @player_x = player_x
    @board_map = board_map
  end

  def show_board
    board = @board_map.to_a.sort_by { |square| square[0] }
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

describe Board do
  describe '#check' do
    it 'returns the winner symbol if there is a winner' do
      board = Board.new(
        'player_o',
        'player_x',
        { A1: 'X', A2: 'X', A3: 'X', B1: '4', B2: '5', B3: '6', C1: '7', C2: '8', C3: '9' }
      )
      expect(board.check).to eql('X')
    end

    it 'returns false if there is no winner' do
      board = Board.new(
        'player_o',
        'player_x',
        { A1: 'X', A2: 'O', A3: 'X', B1: '4', B2: '5', B3: '6', C1: '7', C2: '8', C3: '9' }
      )
      expect(board.check).to eql(false)
    end
  end

  describe '#add' do
    it 'adds the correct symbol to the correct location' do
      board = Board.new('player_o', 'player_x')
      board.add('player_x', '5')
      expect(board.board_map).to eql({ A1: '1', A2: '2', A3: '3', B1: '4', B2: 'X', B3: '6', C1: '7', C2: '8', C3: '9' })
    end
  end
end