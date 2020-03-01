class TicTacToe

  def initialize
    @board = [['_','_','_'],['_','_','_'],['_','_','_']]
    @status = 'inPlay'
  end

  #methods to put pieces on the board
  def put_piece(player, row, col)
    #check for valid user input
    if !row.between?(1,3) or !col.between?(1,3)
      puts "Error: Enter valid row and col"
      return "Error"
    end

    #check if row[col] already exists
    if @board[row-1][col-1] != '_'
      puts "Error: This location already in play"
      return "Error"
    end

    #update board
    @board[row-1][col-1] =  player
  end

  #displays the game board
  def show_board

    puts ""
    @board.each do |x|
      x.each do |y|
        print "#{y} "
      end
      puts ""
    end
    puts ""
  end

  #this method checks if win condition is met and updates @status if met
  def check_win(player)

    #row winner check
    for x in 0..2 do
      for y in 0..2 do
        break if @board[x][y] != player
        if y == 2
          @status = "Player #{player} wins!"
        end
      end
    end

    #col winner check
    for x in 0..2 do
      for y in 0..2 do
        break if @board[y][x] != player
        if y == 2
          @status = "Player #{player} wins!"
        end
      end
    end

    #diag winner check
    for x in 0..2 do
      break if @board[x][x] != player
      if x == 2
        @status = "Player #{player} wins!"
      end
    end

    #anti-diag winner check
    for x in 0..2
      break if @board[x][2-x] != player
      if x == 2
        @status = "Player #{player} wins!"
      end
    end

    @status
  end


end

#main game loop
def play_game(game)
  turnCount = 0
  player = "X"

  loop do
    if turnCount % 2 == 0  #this block cycles through player turn
      player = "X"
    else
      player = "O"
    end

    #ask player for choice
    game.show_board
    puts "Player #{player}, choose row (1-3): "
    row = gets.chomp.to_i
    puts "Player #{player}, choose col (1-3): "
    col = gets.chomp.to_i

    #don't count turn if player enters invalid input.
    if game.put_piece(player, row, col) != "Error"
      turnCount+= 1
    end

    #break loop iif game status was changed or if maximum number of turns is met
    break if game.check_win(player) != 'inPlay' or turnCount == 9
  end

  #post-game messages
  game.show_board
  if game.check_win(player) != 'inPlay'
    puts game.check_win(player)
  else
    puts "DRAW!"
  end

end

game = TicTacToe.new
play_game(game)
