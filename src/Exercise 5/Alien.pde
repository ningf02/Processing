class Alien {
  int x,y;
  int dx,dy;
  int collidex, collidey;
  PImage alienImage, explodeImage;
  int count,loop;
  int random = int(random(100, 1000));
  boolean dead = false;
  Bomb bomb;
  
  Alien(int random){
    alienImage = loadImage("invader.gif");
    explodeImage = loadImage("exploding.gif");
    x = 60 * random;
    y = 0;
  }

  void move(){
    x += dx;
    y += dy;
    if (dy==50)
    y=y+dy; 
    if(x >= width - 30 && x + 30 <= width)
    {
      dx = 0;
      dy = 1;
      y = y + dy;
      count = 0;
    }
    if(x + 30 <= 30 && x >= 0) 
    {
      dx = 0;
      dy = 1;
      y = y + dy;
      count = 0;
    }
    if(y % 25 == 0 && y != 0 && count == 0)
    {
      if(count == 0) 
      {
        count = 1;
      }
      dy = 0;
      if(x > 600) 
      {
        dx = -10;
      }
      if(x < 600)
      {
        dx = 10;
      }
    }
  }
  void draw() {
    if(dead == false) 
    image(alienImage, x, y);    
  }
  void explode() {
    if(((collidex > x && collidex < x + 30) || (collidex + 10 > x && collidex < x + 30)) && (collidey < y + 25 && collidey > y)) 
    {
      dead = true;
      if (y<height)
      dy=50;
    }
    if(dead == true)
    image(explodeImage, x, y);
       
  }
}
