# noun : board, player
# verb : draw_ttt_board, player_pick_position, computer_pick_position, check_win, empty_position, any_winner

class Board
  attr_accessor :position
  def initialize
    @position = {}
    25.times {|position| @position[position+1] = ' '}
  end

  def draw
    system('clear')
    puts ""
    puts "Position guide!                          "
    puts ""
    puts "---------------------           ---------------------"
    puts "| 1 | 2 | 3 | 4 | 5 |           | #{position[1]} | #{position[2]} | #{position[3]} | #{position[4]} | #{position[5]} |"
    puts "---------------------           ---------------------"
    puts "| 6 | 7 | 8 | 9 | 10|   ====>   | #{position[6]} | #{position[7]} | #{position[8]} | #{position[9]} | #{position[10]} |"
    puts "---------------------           ---------------------"
    puts "| 11| 12| 13| 14| 15|           | #{position[11]} | #{position[12]} | #{position[13]} | #{position[14]} | #{position[15]} |"
    puts "---------------------           ---------------------"
    puts "| 16| 17| 18| 19| 20|           | #{position[16]} | #{position[17]} | #{position[18]} | #{position[19]} | #{position[20]} |"
    puts "---------------------           ---------------------"
    puts "| 21| 22| 23| 24| 25|           | #{position[21]} | #{position[22]} | #{position[23]} | #{position[24]} | #{position[25]} |"
    puts "---------------------           ---------------------"
    puts ""
  end

  def empty_position
    position.select { |position, value| value == ' '}.keys
  end

  def mark_position(marker)
    if marker == "X"
      available_position = empty_position
      puts "Player pick a position #{available_position}: "
      player_position = gets.chomp.to_i
      position[player_position] = marker
    else
      computer_position = empty_position.sample
      position[computer_position] = marker
    end
  end

  def check_win
    win_formula = [[1,2,3,4,5], [6,7,8,9,10], [11,12,13,14,15], [16,17,18,19,20], 
    [21,22,23,24,25], [1,6,11,16,21], [2,7,12,17,22], [3,8,13,18,23],
    [4,9,14,19,24],[5,10,15,20,25],[1,7,13,19,25],[5,9,13,17,21]]
    win_formula.each do |line|
      if (position[line[0]] == 'O') && 
        (position[line[1]] == 'O') && 
        (position[line[2]] == 'O') &&
        (position[line[3]] == 'O') &&
        (position[line[4]] == 'O')
        return 'Computer'
      elsif (position[line[0]] == 'X') && 
        (position[line[1]] == 'X') &&
        (position[line[2]] == 'X') &&
        (position[line[3]] == 'X') && 
        (position[line[4]] == 'X')
        return 'Player'
      end
    end
    nil
  end
end

class Square < Board
  def mark(symbol)
    @position = symbol
  end

end

class Player
  attr_reader :name, :marker
  def initialize(name,marker)
    @name = name
    @marker = marker
  end
    
  def to_s
    "#{name} using #{marker}"
  end
end

class Game
  attr_reader :player, :computer, :current_player

  def initialize
    display_welcome_start_game_message
    puts "Enter your name: "
    player_name = gets.chomp
    @player = Player.new(player_name, "X")
    @computer = Player.new("Chris_aka_bot", "O")
    @current_player = player
#    puts "#{player}"
#    puts "#{computer}"
#    puts "#{@current_player}"
  end

  def play
    loop do
      winner = nil
      board = Square.new
      board.draw
      begin
        board.mark_position(current_player.marker)
        board.draw
        winner = board.check_win
        switch_player
      end until winner || board.empty_position.empty?
      display_result(winner)
      puts "Type 'y' to replay again."
      break if gets.chomp.downcase != 'y'
    end
  end

  def display_welcome_start_game_message
    system('clear')
    puts "Welcome to Tic - Tac - Toe game!"
    puts "Start game!"
  end

  def switch_player
    if current_player ==  player
      @current_player = computer
    else
      @current_player = player
    end
  end

  def display_result(result)
    if result == 'Player'
      puts "#{player.name} win!"
    elsif result == 'Computer'
      puts "#{computer.name} win!"
    else
      puts "It's tie!"
    end
  end
end

Game.new.play