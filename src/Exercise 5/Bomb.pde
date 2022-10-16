class Bomb {
  int x, y;
  int dy= 11;
  PImage image;
  
  Bomb(int xpos, int ypos, PImage currentImage ){
    image = currentImage;
    image = loadImage("Bomb.png");
    x = xpos;
    y = ypos;
  }
  void move()
  {
    y += dy;
  }
  void draw() {
     image(image,x,y);
  }
  boolean collide(Player xp) {
    if((y + 15 > xp.ypos && y < xp.ypos - 10) && (x + 15 > xp.xpos && x < xp.xpos + 100))
    {
      return true;
    }
    else return false;
  }
}
