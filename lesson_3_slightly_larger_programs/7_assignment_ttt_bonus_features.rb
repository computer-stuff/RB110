require 'pry' # importing the gem

WINNING_COMBINATIONS = [[0, 1, 2], [3, 4, 5], [6, 7, 8]] + # rows
                [[0, 3, 6], [1, 4, 7], [2, 5, 8]] + # cols
                [[0, 4, 8], [2, 4, 6]]              # diagnals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

def display_welcome
  system 'clear'
  prompt("Welcome to Tic Tac Toe!")
end

# rubocop:disable Metrics/AbcSize
def display_board(board, match_num, total_matches, scores)
  system 'clear' # running a terminal command
  # example binding.pry
  # brb # {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
  # brb[2] # " "
  # brb[0] # nil
  puts ""
  puts "     |     |"
  puts "  #{board[0]}  |  #{board[1]}  |  #{board[2]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[3]}  |  #{board[4]}  |  #{board[5]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[6]}  |  #{board[7]}  |  #{board[8]}"
  puts "     |     |"
  puts ""
  prompt "Match #{match_num} of #{total_matches}"
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
end
# rubocop:enable Metrics/AbcSize

# initialzes an array of size 9 with every value set to INITIAL_MARKER
def initialize_board
  new_board = Array.new(9)
  new_board.map! { INITIAL_MARKER } # [0] = INITIAL_MARKER, [1] = INITIAL_MARKER
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a position to place a piece: #{
      joinor(
        empty_squares(brd)
      )
    }"
    square = gets.chomp.to_i - 1
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  brd[square] = PLAYER_MARKER
end

def empty_squares(brd)
  brd_keys = brb.keys
  brd_keys.select do |num|
    brd[num] == INITIAL_MARKER
  end
end
# brb.keys.select { |num| brd[num] == INITIAL_MARKER }

def joinor(arr, delimiter=', ', word='or')
  case arr.size
  when 0 then ''
  when 1 then arr.to_s
  when 2 then arr.join(" #{word} ")
  else
    arr[-1] = "#{word} #{arr.last}"
    arr.join(delimiter)
  end
end

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_match_winner(brd)
end

def detect_match_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def keep_score(winner, scores)
  player_wins = 0
  computer_wins = 0
  matches = 0


end
  if winner == 'Player'
    scores[:Player] += 1
  else winner == 'Computer'
    scores[:Computer] += 1
  end
end


end
# Functions are just fancy variables of type 'function'
# Lambadas are unnamed functions

loop do
  board = initialize_board() # put paretheses to know it is a method.

  loop do
    display_board(board)

    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)

    computer_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  # best_out_of_five()

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"


# reset with tic tac toe
# take intial code do a reverse pedac
# understand how to solve the problems other more important half is able to code in head
#   - as you're reading code your executing the code
#   - become a ruby interpreter
#   - doing binding.pry next next next in head
#
# two hours reverse pedac
# * get to this at 8 hours over 3 days then can take chatgpt copy the full code in prep prompt
#   interact with chatgpt to understand everyline of the code
#
# do pedac for keep score
# tracking changes to git
# 