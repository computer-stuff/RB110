=begin
Problem:
Implement a CLI tic tac toe game:
- Have two players one is the computer the other is a
user that inputs their response in the terminal
- There are only only 8 winning combonations for the board
- the board is always 3X3
- The first player to reach three of their marker in a row
wins that round
- If all 9 squares are marked and neither player marker is
3 in a row then its a draw.


Examples/Modeling:



Data Types:
- Can use strings for the board creation
- Can use arrays for the winning combonations
and to select from board

Algorithm:

* create a simple prompt helper method to streamline printing a prompt
to the terminal for the user we define the method at the top after constants as
```
def prompt(msg)
  puts "=> #{msg}"
end
```
in this method we call the `puts` method to print the given string to the console
it has one argument `msg` which gets interpolate into the prompt the msg local
variable will reference whatever string is passed to the prompt method.


beginning of game loop
- initalize_board
 `board = initialize_board`
  - setting the local variable `board` to the return value of the method call
    to the initialize_board method
    ```
    def initialize_board
     new_board = {}
     (1..9).each { |num| new_board[num] = INITIAL_MARKER }
     new_board
    end
    ```
    - in the `initialize_board` method definition we are
      - initializing a new hash to the `new_board` local variable
      - then we are calling the each method on an inclusive range`(1..9)` and passing
        it a block in the block there is one parameter num, which references each
        number as we interate through the range.
      - In the block we are using the `Hash#[]=` method to create/assign
        values (INITIAL_MARKER) to each key (number in range). This is the syntax
        to create a new key value pair in ruby hsh[key] = value.
        - At the top we have defined a few constants one being the INITIAL_MARKER =  `' '`
          it is an empty space which acts as a place holder on the board before a player places a piece
      - Then will implicitily return `new_board` as it is the last evaluated expression in the method def


- display the empty 3x3 board to the user
    `display_board(board)`
    - Now we are in the inner game loop and we call the `display_board` method
      we pass in `board` as an argument into the `display_board` method
    ```
    def display_board(board)
      system 'clear'
      puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
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
    ```
    - In this method definition we pass it one argument `board` which references
      the same object as `board` from the intial game loop which references the
      hash created in the `initialize_board` method
    - Then we run a terminal command `'clear'`
      - we do this by calling the Ruby `system` method `system("command_here")`
        the system will make your Ruby program wait until the cmd is done.
        `system` returns 3 possible values
          - `true` if cmd worked
          - `false` if the cmd returns and error code
          - and `nil` if cmd execution fails (cmd not found)
            this will run the terminal cmd clear in the terinal to clear the
            terminal space so that after each turn the board/screen is cleared
            and replaces with the updated version instead of having each turn
            show up seperatly one after another in the terminal window
    - Then to display the board we use the `puts` method and strings to first
      display a msg to user that they are the `PLAYER_MARKER` which is 'X'
      and the `COMPUTER_MARKER` is 'O'
    - Then we `puts` an empty string so that there is a blank line inbetween
      the msg and the board display
    - Then we call `puts` and have the string ` "     |     |"` as our first
      line of the board
    - Then on the next line we use string interpolation #{} and the `Hash#[]`
      method to reference the values of the board hash which rn are the strings
      with one space in them `INITIAL_MARKER`
        - `#{board[1]}` says interpolate the value at key 1 in the board hash,
          which is `' '`. We also make sure to line these values up with the
          middle of all 9 squares
    - Then there is `puts` called and passed "     |     |"` as our third line
    - Then our 4th line of the board is  `puts "-----+-----+-----"`
    - and so on until we have 9 squares



** before the `player_places_piece!` method definiton we need to write in a helper method
   `empty_squares` method above
```
def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end
```
  The empty_squares method has one argument, board, which references the hash.
  - In the method we call the `keys` method on `board` this returns an array
    containing all the keys in the hash in this case this will return an array
    with nums 1 through 9 `[1, 2, 3, 4, 5, 6, 7, 8, 9]`
  - Then we have a chained method onto the return value of `board.keys` we call
    the `select` method on the array returned from `board.keys`. `board.keys.select`
    is passed a block `{ |num| board[num] == INITIAL_MARKER }` in the block there is
    one block parameter, `num`, which references each number in the array above.
    In the block we then use element reference and double equals == to determine the
    empty squares. on the first iteration it board at num 1, which would be the key
    1 equals the INITIAL_MARKER, `' '`, then the block will return `true` if it does
    not equal INITIAL_MARKER, then the block will return false. `select` will use
    the return value of the block to select which numbers in the array which also
    reference the key, which reference the squares which ones are empty or which
    ones the block returns true for.

```
def player_places_piece!(board)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(board).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  board[square] = PLAYER_MARKER
end
```

- Ask the User to play a piece, player chooses from all available/empty squares
  - Still in the inner game loop after we call the `display_board` method and pass
    it the `board` which references the hash with keys 1..9 and initial values all as `' '`
    which is referenced by `INITIAL MARKER`
  - Then we call the `player_places_piece!` method and pass it one argument the same `board` which
    references the hash.
    - Now going up to the `player_plaecs_piece!` method defintion
      - the method definition has one argument, `board`, which references the hash
      - then we intialize the local variable `square` and set it equal to an empty string
      - then we have a loop
        - in the loop we display a prompt to the user *prompt method at top
          `prompt "Choose a square (#{empty_squares(board).join(', ')}):"`
          in the prompt we are asking the user to choose a square we then use string interpolation `#{}` to
          display the square option to the user. In the `#{}` we call the **`empty_squares` method
          and pass it one argument the hash referenced by `board`. This will return an array of numbers
          that reference which keys or squares on the board are empty and have the initial marker.
          - we then call the `join` method on the array that is returned by the `empty_squares` method call
            this will return a new string containging all the numbers from the array,
            we then pass the join method a seperator argument, the string, `', '`. This will be the delimiter between
            each number so that they are spaced out with commas separated them rather than '123456789'
            - SHORTER VERSION more realistic to say in work context: prompting user to pick a square, what's happeing in the string interpolation is =>
              getting list of empty squares and formatting them with the join method.
          - we then reassign the local variable square to the users input
            we call the `gets` method to read user input the program will wait for the user to type
            input and press the enter key. This will return a string since we are assigning that string to a
            variable `square` we'll be able to use it. we also call `chomp` on the gets bc without it gets will add
            a new line character `\n` ??(which is the enter key's new line character so gets takes all the letters and the
            enter key's new line character \n) so chomp removes the newline character at the end of strings. Since `gets`
            returns a string value we then call `.to_i` on the gets.chomp.to_i to finally convert the user's input from
            a string into an integer
          - we then add a `break if` statement which means we will break out of this choose a square prompt loop if
            this condition returns true `empty_squares(board).include?(square)` we call the `include?` method on the
            return value of the `empty_squares` method called with board passed which returns all the squares left
            on the board that have the initial marker in their space. We pass in the number collected from the user's
            input `square` as an argument to the `include?` method and if that number matches one of the numbered squares
            that is empty then we will break out of this loop and execute the next line of code in this method
            `board[square] = PLAYER_MARKER` Which uses element assignment to assign the `PLAYER MARKER`, 'X', whatever
            square on the board that corresponds with the number the user input into the prompt.
          - if `empty_squares(board).include?(square)` returns false and corresponding square t the user's number input
            is not 'empty' or doesn't just have an initial marker then we stay in the loop call the prompt method to
            display a msg to the user that their choice is not valid, and then it should loop again from the start with
            choose a square... unitl they make a valid choice
    - Now in the main game loop in the this inner loop of displaying the board and the player and computer placing
      pieces. after we call `player_places_piece!` we break out of the loop if the `someone_won?` method or
      the `board_full` method calls return true
      `break if board_full?(board) || someone_won?(board)`
      - `board_full` method
        - This method has one argument the board (original hash). In the method we call
          the `empty?` method on the return value of the `empty_squares(board)` method call
          as we know the `empty_squares` selects all the keys that have `INITIAL_MARKER` as
          there corresponding value and returns an array. `empty?` returns true or false
          if the count of the elements in the array is zero it returns true otherwise it returns false
          in our or condition, `||`, if either method implentation returns true then the break condition
          will be executed
      - `someone_won?` method
        - in the method we call the `detect_winner(board)` method and pass it one argument
          the board which references the hash. There is the double bang in front of the method
          this is the double negation operator. One bang ! means boolean value of object but opposite
          the double bang !! means ??express?? the true boolean value of the object so it makes it a boolean
          thats the opposite and then switched that boolean to what it actually is true or false given the truthyness
          This converts a value to a boolean true/false thats the opposite then because its double bang !! it then switched
          the boolean value to what it actually is. This is just two negations combined not a special operator
          This method will return true and execute if `detect_winner` method returns a truthy value so if either
          the user or the computer get 3 across and either 'Player' or 'Computer' is returned by detect_winner
          then `someone_won` will return true else it will return false because `detec_winner` will
          return `nil`
            - The helper `detect_winner` method is passed an argument `board` ( the hash )
            ```
            def detect_winner(board)
              WINNING_LINES.each do |line|
                if board.values_at(*line).count(PLAYER_MARKER) == 3
                  return 'Player'
                elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
                  return 'Computer'
                end
             end
             nil
            end

            - In the method we call the `each` metohd on the constant, `WINNING_LINES`, this constant
            is defined at the top of our program and is initialized and assigned to arrays of arrays
            there are three main array consisting of sub-arrays that each have three integers in them
            the integers reference the squares on the board 1-9 and the sub-arrays reference the winning combos
            for each pattern of three, the main arrays reference which part of the board the 3 across is going
              either rows columns or diagnal wins
          - so we call each on this constants which references arrays and we pass it a block with one block  parameter
            `line`, this references each sub-array of 3 integers, marking the winning groups of 3 across the board
            - In the block there is an `if/else` statement,
              for the if statement: we call the `values_at` method on board (the hash) and pass it one argument (*line)
              line with the splat operator in front of it. This allows us to pass the winning combos, which are arrays
              to the values_at method being called on the hash, board, and then it will break down that array so that
              each element is passed into values_at one at a time we could write that as (line[0], line[1], line[2]),
              but that's a hassel so *line does that for us under the hood.
              ```
              def detect_winner(board)
                # line ==> [1, 2, 3]
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
          - The `*` splat allows you to pass an array of values into a method and it will pass the values into the method
            one by one. So what we are essentially saying is on iteration zero if the values at square 1, 2, and 3 or
            the values for the keys 1, 2, and 3 in our board hash count up to 3 then return the string `'Player'`
            so Ruby will go okay heres the board hash we want the values at line[0], line[1], and line[2] (which references the first sub-array of
            WINNING_LINES) so values_at square 1, 2, and 3 then we call the count method on that and pass in the argument
            PLAYER_MARKER which references the string 'X' so if the number of 'X' values at line [0]... count up to 3
            then return the player string
          - then we have an elsif statement and do the same process but for the COMPUTER_MARKER 'O', and if that == 3 then
            we return the string 'Computer'
          - then we exit our if/else statement and if neither of those statements execute we implicitly return `nil` or
            nothing.

```
computer_places_piece!(board)
    break if board_full?(board) || someone_won?(board)
```
  - Computer plays a piece chooses from all available/empty squares
    - now we are still in the inner loop of the game loop and the player has placed a piece
      no one won and the board isn't full so now the `computer_places_piece!` method will execute
      we passed the board as an argument to the `computer_places_piece!` method, and we have the same break if
      conditions just like the player_places_piece! method
```
def computer_places_piece!(board)
  square = empty_squares(board).sample
  board[square] = COMPUTER_MARKER
end
```
- In this method above there is one argument the board hash
  - in the method we initialize the `sqaure` local variable and assign it to the return value
    of calling the `empty_squares` method with board passed in as an argument and then chaining the `sample` method call
    to that.
    -the `empty_squares` method will return all the key values (square numbers)
     that do not have a player or computer piece in them all the squares that just
     have the Initial_marker which is an empty string.
    - the `sample` method with no arguments returns a random object from self, which in
      this case will be the array of keys which will randomly pick one of the empty squares
    - Then we use that integer that sample returns and we call the element reference method
      on `board` the hash and using element reference`#[]` we pass in that value of `square`
      the syntax happen is `hash[key] => value` this return the value associated with the given key in
      the board hash. we then assign that value to `COMPUTER_MARKER`. this will set the value at the radomly selected
      square to `'O'`

  - now we keep going around the loop displaying the board, then player places a piece
  then computer places a piece until one of the break condiitons is met.


Then once the board is full or someone won we break out of the loop.

We are now back in the outer main game loop the `display_board` method is called and passed the
`board` hash as an argument.
  - This will again run a terminal command `'clear'` to clear and reload the completed boar in the terminal
  - then it will print out all the strings calling the `puts` method
      - telling the user who each piece represetns
      - then displaying teh board will all the player and computer markers


```
  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end
```
Then in the main game loop there is an if/else statement
- For the `if` branch
  - we call the someone_won? method and pass in `board` to the method as an argument
    as we know the someone_won? method returns the boolean value representation of what the detect_winner method returns
    and as we know the detect_winner method will either return the string 'Player', the string 'Computer' or nil it does this
    by callinhg `each` on the WINNING_LINES constant and then in an `if/else` statment
    calling `values_at` on the board hash passing in each sub-array of WINNING_LINES as an argument
    then calling the count method of the return value of that and passing in PLAYER_MARKER as an argument and then comparing
    that return value of how many values in said sub-array are the player marker and if they
    count to 3 then returning the 'Player' string and so on
      - so if someone_won then we call the prompt method and pass it a string
      in the string we have string interpolation in the string interpolation we call the
      detect_winner method and pass in board as an argument this return value will either be
      'Player' or 'Computer' this will be interpolated into the string and display to the user
      either "Player won!" or "Computer won!"
      - this if branch will only be executed if `someone_won?` returns a truthy value otherwise the
        else branch will be exectued
- For the `else` branch
  - the `prompt` method is called again and passed a string `"It's a tie!`
- Once either the if or else branch executes then we are out of the if/else statement


The we call prompt in the main game loop.
- we pass the prompt method a string to print to the user `"Play aggain? (y or n)"`
  - then we initlaize and assign a new local variable `answer` to the users input calling the `gets.chomp`
    method chain
    - the gets method will wait for user input and then read that user input in string form
      chomp will remove the new line character `/n` from the string that is returned by gets
    - then we have a `break unless` condition. The condition being, break unless answer from user
      starts with a lowercase 'y'



if the board is full announce that there is a draw to the user
- If neither winner nor draw go back to ask user to play a piece
- Ask the User if they want to play again
  -retrieve answer
  - if they answer no then display Goodbye! prompt
  ```
  prompt "Play aggain? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
  ```
  - we call the downcase method on answer (which is the user input) this will make
    the string lowercase letters
  - then we call the start_with? method and pass it one argument the string value 'y'
    so answer references the user input it will be downcased to lowercase letters and then if it starts with a y and
    the start_with?('y') method call returns true then the game loop will begin again and loop
    back around.
  - If it returns false and the user enters anythign that does not start with a 'y'
  then we will break out of the main game loop

we then call the prompt method outside of the main game loop and pass it a string
to display to the user thank you for playing and say goodbye
then the program will stop running once the prompt last line executes.





Code:
=end

require 'pry'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                [[1, 5, 9], [3, 5, 7]]              # diagnals
INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(board)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}."
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
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
  binding.pry
end

def player_places_piece!(board)
  square = ''
  loop do
    prompt "Choose a square (#{empty_squares(board).join(', ')}):"
    square = gets.chomp.to_i
    break if empty_squares(board).include?(square)
    prompt "Sorry, that's not a valid choice."
  end
  board[square] = PLAYER_MARKER
end

def computer_places_piece!(board)
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

loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    break if board_full?(board) || someone_won?(board)

    computer_places_piece!(board)
    break if board_full?(board) || someone_won?(board)
  end

  display_board(board)

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
  else
    prompt "It's a tie!"
  end

  prompt "Play aggain? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Goodbye!"
