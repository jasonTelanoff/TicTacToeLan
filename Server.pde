class ServerGame extends Game {
  Server s;
  Client c;

  int[][] board = new int[3][3];
  boolean xTurn = true, someoneWon = false, xWon;

  ServerGame(int port) {
    for (int y = 0; y < board.length; y++)
      for (int x = 0; x < board[y].length; x++)
        board[y][x] = 0;

    s = new Server(two_player_tic_tac_toe.this, port);
  }

  void draw() {
    if (!someoneWon) {
      c = s.available();
      if (c != null) {
        String input = c.readString();
        input = input.substring(0, input.indexOf("\n"));
        println(input);
        String[] data = input.split("");
        if (!xTurn)
          checkPress(Integer.parseInt(data[0]), Integer.parseInt(data[1]));
      }
    }

    background(240);

    strokeWeight(2);
    stroke(0);
    line(200, 0, 200, 600);
    line(400, 0, 400, 600);
    line(0, 200, 600, 200);
    line(0, 400, 600, 400);

    textAlign(CENTER, CENTER);
    textSize(50);
    fill(0);
    for (int y = 0; y < board.length; y++)
      for (int x = 0; x < board[y].length; x++)
        if (board[y][x] != 0) text(board[y][x] == 1 ? "X" : "O", x * 200 + 100, y * 200 + 100);

    if (someoneWon) {
      textSize(100);
      stroke(255);
      strokeWeight(5);
      fill(100, 20, 20);
      text((xWon ? "X" : "O") + " Won!", 300, 300);
    }
  }

  void mouseClicked() {
    if (!someoneWon) {
      int x = mouseX/200, y = mouseY/200;
      if (xTurn) 
        checkPress(x, y);
    }
  }

  void checkPress(int x, int y) {
    if (board[y][x] == 0) {
      board[y][x] = xTurn ? 1 : 2;
      s.write((xTurn ? "x" : "o") + x + y + "\n");

      if (board[0][x] != 0 && board[0][x] == board[1][x] && board[1][x] == board[2][x])
        win(x, 0);
      else if (board[y][0] != 0 && board[y][0] == board[y][1] && board[y][1] == board[y][2])
        win(0, y);
      else if (board[1][1] != 0 && board[0][0] == board[1][1] && board[1][1] == board[2][2])
        win(1, 1);
      else if (board[1][1] != 0 && board[0][2] == board[1][1] && board[1][1] == board[2][0])
        win(1, 1);
    }
    xTurn = !xTurn;
  }

  void win(int x, int y) {
    s.write("w" + (board[y][x] == 1 ? "x" : "o"));
    someoneWon = true;
    xWon = board[y][x] == 1;
  }
}
