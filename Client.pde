class ClientGame extends Game {
  Client c;

  int[][] board = new int[3][3];
  boolean myTurn = true, someoneWon = false, IWon;

  ClientGame(String ip, int port){
    for (int y = 0; y < board.length; y++)
      for (int x = 0; x < board[y].length; x++)
        board[y][x] = 0;

    c = new Client(two_player_tic_tac_toe.this, ip, port);
  }

  void draw() {
    if (c.available() > 0) {
      String input = c.readString();
      print(input);
      String[] data = input.split("\n");
      for (int i = 0; i < data.length; i++) {
        if (data[i].charAt(0) == 'w') {
          someoneWon = true;
          IWon = data[i].charAt(1) == 'o';
        } else {
          String[] moveData = data[i].split("");

          board[Integer.parseInt(moveData[2])][Integer.parseInt(moveData[1])] = moveData[0].charAt(0) == 'x' ? 1 : 2;
        }
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
      text(IWon ? "You Won!" : "You Lost :(", 300, 300);
    }
  }

  void mouseClicked() {
    if (!someoneWon) {
      int x = mouseX/200, y = mouseY/200;
      c.write("" + x + y + "\n");
    }
  }
}
