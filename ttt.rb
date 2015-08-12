# Check README.md for pseudo code

require 'pry'

def clear_ttt_board(update_position)
  9.times {|position| update_position[position+1] = ' '}
end

def draw_ttt_board(update_position)
  system('clear')
  puts ""
  puts "Position guide!                          "
  puts ""
  puts "-------------               -------------"
  puts "| 1 | 2 | 3 |               | #{update_position[1]} | #{update_position[2]} | #{update_position[3]} |"
  puts "-------------               -------------"
  puts "| 4 | 5 | 6 |    ====>      | #{update_position[4]} | #{update_position[5]} | #{update_position[6]} |"
  puts "-------------               -------------"
  puts "| 7 | 8 | 9 |               | #{update_position[7]} | #{update_position[8]} | #{update_position[9]} |"
  puts "-------------               -------------"
  puts ""
end

def player_pick_position(update_position)
  available_position = empty_position(update_position)
  puts "Player pick a position #{available_position}: "
  player_position = gets.chomp.to_i
  update_position[player_position] = 'X'
end

def computer_pick_position(update_position)
  computer_position = empty_position(update_position).sample
  update_position[computer_position] = 'O'
end

def check_win(update_position)
  win_formula = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  win_formula.each do |line|
    if (update_position[line[0]] == 'O') && 
      (update_position[line[1]] == 'O') && 
      (update_position[line[2]] == 'O')
      return 'Computer'
    elsif (update_position[line[0]] == 'X') && 
      (update_position[line[1]] == 'X') && 
      (update_position[line[2]] == 'X')
      return 'Player'
    end
  end
  nil
end

def empty_position(update_position)
  update_position.select { |position, value| value == ' '}.keys
end

def any_winner(result)
  if result == 'Player'
    puts "#{result} win!"
  elsif result == 'Computer'
    puts "#{result} win!"
  else
    puts "It's tie!"
  end
end

loop do
  winner = nil
  hsh_position ={}
  clear_ttt_board(hsh_position)
  draw_ttt_board(hsh_position)
  begin
    player_pick_position(hsh_position)
    draw_ttt_board(hsh_position)
    winner = check_win(hsh_position)
    computer_pick_position(hsh_position)
    draw_ttt_board(hsh_position)
    winner = check_win(hsh_position)
  end until  winner || empty_position(hsh_position).empty?
  any_winner(winner)
  puts "Type 'y' to replay again."
  break if gets.chomp.downcase != 'y'
end