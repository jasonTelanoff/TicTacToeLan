import processing.net.*;

Game game;

void setup() {
  size(600, 600);

  game = new ServerSelection();
}

void draw() {
  game.draw();
}

void mouseClicked() {
  game.mouseClicked();
}

void keyPressed() {
  if (game instanceof ServerSelection)
    if (keyCode >= 48 && keyCode <= 57) {
      if (((ServerSelection) game).port.length() < 5)
        ((ServerSelection) game).port += key;
    } else if (keyCode == 8 && ((ServerSelection) game).port.length() > 0)
      ((ServerSelection) game).port = ((ServerSelection) game).port.substring(0, ((ServerSelection) game).port.length() - 1);
    else if (keyCode == 10)
      game.mouseClicked();
}
