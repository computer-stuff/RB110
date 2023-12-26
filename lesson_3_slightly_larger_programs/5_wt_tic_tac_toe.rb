=begin
Tic Tac Toe is a 2 player game played on a 3x3 board.
Each player takes a turn and marks a square on the board.
First player to reach 3 squares in a row, including
diagonals, wins. If all 9 squares are marked and no
player has 3 squares in a row, then the game is a tie.

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square.
3. Computer marks a square.
4. Display the updated board state.
5. If winner, display winner.
6. If board is full, display tie.
7. If neither winner nor board is full, go to #2
8. Play again?
9. If yes, go to #1
10. Good bye!
=end

require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagnals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
PLAYER_NAME = 'Player'
COMPUTER_NAME = 'Computer'
ROUNDS_LIMIT = 5

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end

# rubocop:enable Metrics/AbcSize
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }

  # For testing winning/defensive scenarios
  #   X  |  X  |  O
  # -----+-----+-----
  #      |  X  |
  # -----+-----+-----
  #      |  O  |  O
  # new_board = {
  #   1 => PLAYER_MARKER,
  #   2 => PLAYER_MARKER,
  #   3 => COMPUTER_MARKER,
  #   4 => INITIAL_MARKER,
  #   5 => PLAYER_MARKER,
  #   6 => INITIAL_MARKER,
  #   7 => INITIAL_MARKER,
  #   8 => COMPUTER_MARKER,
  #   9 => COMPUTER_MARKER,
  # }

  new_board
end

def initialize_scores
  return {
    PLAYER_NAME => 0,
    COMPUTER_NAME => 0,
  }
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def joinor(arr, delimiter, final_delimiter)
  return arr[0] if arr.size == 1

  # For every item in the arr[0..-2]
    # join with delimiter
  # and join last item with final_delimiter
  return [
    arr[0..-2].join(delimiter),
    arr[-1],
  ].join(final_delimiter)
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(board), ', ', ' or ')}):"
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  board[square] = PLAYER_MARKER
end

def line_at_risk?(board, line, opponent_marker)
  if board.values_at(*line).count(opponent_marker) != 2
    return false
  end

  if board.values_at(*line).count(INITIAL_MARKER) != 1
    return false
  end

  return true
end

def computer_places_piece!(board)
  # if at risk, play defensively
  # if about to win, play winning move
  # else, random
  #
  # func at risk:
  #   for every winning line
  #     if line has markers from opponent and 1 empty spot
  #        pick empty spot

  # line --> array of keys into the board hash
  # board --> keys (spots on a board), values (marker in the spot)
  # board.values_at(*line) --> give me the values at each of these spots on the board
  # board.values_at(*line).index(INITIAL_MARKER) --> give me the index, in the line, of the empty spot in this list of values
  # line[board.values_at(*line).index(INITIAL_MARKER)] --> give me the key of the empty spot on the board
  WINNING_LINES.each do |line|
    if line_at_risk?(board, line, COMPUTER_MARKER)
      index_of_at_risk_line = board.values_at(*line).index(INITIAL_MARKER)
      index_to_place_marker_at = line[index_of_at_risk_line]
      board[index_to_place_marker_at] = COMPUTER_MARKER
      return
    end
  end

  WINNING_LINES.each do |line|
    if line_at_risk?(board, line, PLAYER_MARKER)
      index_of_at_risk_line = board.values_at(*line).index(INITIAL_MARKER)
      index_to_place_marker_at = line[index_of_at_risk_line]
      board[index_to_place_marker_at] = COMPUTER_MARKER
      return
    end
  end

  if board[5] == INITIAL_MARKER
    board[5] = COMPUTER_MARKER
    return
  end

  square = empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return PLAYER_NAME
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return COMPUTER_NAME
    end
  end

  nil
end


loop do
  scores = initialize_scores

  prompt "Would you like to go first? (y or n)"
  answer = gets.chomp

  player_goes_first = answer.downcase.start_with?('y')
  loop do
    board = initialize_board

    loop do
      if player_goes_first
        display_board(board)
        player_places_piece!(board)
        break if board_full?(board) || someone_won?(board)

        computer_places_piece!(board)
        break if board_full?(board) || someone_won?(board)
      else
        computer_places_piece!(board)
        break if board_full?(board) || someone_won?(board)

        display_board(board)
        player_places_piece!(board)
        break if board_full?(board) || someone_won?(board)
      end
    end

    display_board(board)

    # tell them the score so far we also tell them who won that round or tell them if its a tie
    # ask if they want to play another round or stop the game there play

    if someone_won?(board)
      winner = detect_winner(board)
      scores[winner] += 1
      puts "#{winner} won this round!"
    else
      puts "It's a tie!"
    end

    puts "####################"
    puts "## Current scores ##"
    puts "####################"
    scores.each do |player_name, current_score|
      puts "#{player_name}: #{current_score}"
    end

    break if scores.values.include?(ROUNDS_LIMIT)

    prompt "Play next game? (y or n)"
    answer = gets.chomp

    break unless answer.downcase.start_with?('y')
  end

  if scores.values.include?(ROUNDS_LIMIT)
    overall_winner = scores.invert[ROUNDS_LIMIT]
    prompt "#{overall_winner} won the set of matches!"
  end

  prompt "Play another round of #{ROUNDS_LIMIT}? (y or n)"
  answer = gets.chomp

  # If break happens, loop exits and game ends
  break unless answer.downcase.start_with?('y')
end


prompt "Thanks for playing Tic Tac Toe! Goodbye!"
