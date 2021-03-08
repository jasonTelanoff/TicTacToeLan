class ServerSelection extends Game {
  String port = "";
  void draw() {
    background(240);
    
    fill(0);
    textAlign(CENTER, BOTTOM);
    textSize(40);
    text("port", 300, 270);
    
    textAlign(CENTER, CENTER);
    textSize(50);
    
    text(port, 300, 300);
  }
  
  void mouseClicked() {
    if(port.length() > 3)
      game = new ServerGame(Integer.parseInt(port));
  }
}
