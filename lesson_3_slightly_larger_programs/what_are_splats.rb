

def print_these_values(a, b=nil, *args)
  puts "a: #{a}"
  puts "b: #{b.nil? ? 'nil' : b}"
  args.each_with_index do |val, i|
    puts "args[#{i}]: #{val.nil? ? 'nil' : val}"
  end
end


arr = [1, 2, 3, 4]
# print_these_values(arr[0], arr[1], arr[2])
# print_these_values(*arr)
# print_these_values(arr[0], arr[1], arr[2], arr[3])

# print_these_values(a=arr[0], b=arr[1], args=[arr[2], arr[3]])
#
# print_these_values(2, 1, 3)


# keyword arguments
def print_these_key_values(a:, b: nil, **kwargs)
  puts "a: #{a}"
  puts "b: #{b.nil? ? 'nil' : b}"
  kwargs.each do |(k, v)|
    puts "#{k}: #{v.nil? ? 'nil' : v}"
  end
end

values = {
  a: 1,
  b: 2,
  c: 3,
  d: 4,
  ff: 'e'
}

# values.each -->
# [[:a, 1], [:b, 2], [:c, 3]]

print_these_key_values(**values)


# From Tic Tac Toe Game Interpreter Brain downloading...

def detect_winner(board)
  WINNING_LINES.each do |line|
    # line ==> [1, 2, 3]
    # if board.values_at(*line).count(PLAYER_MARKER) == 3
    # if board.values_at(line[0], line[1], line[....]).count(PLAYER_MARKER) == 3
    # if board.values_at(line[0], line[1], line[....]).count('X') == 3
    # if board.values_at(1, 2, 3).count('X') == 3
    # if {....}.values_at(1, 2, 3).count('X') == 3
    # if [nil, 'O', X].count('X') == 3
    # if 1 == 3
    # if false
    if board.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end
