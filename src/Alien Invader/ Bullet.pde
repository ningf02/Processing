
class Bullet {
  int x,y;
  int dx;
  int dy;
  //int radius=10;
  PImage image;
  float randomImage = random(0,6);
  Bullet(int mouseX, PImage currentImage){
    image = currentImage; 
    if (randomImage > 0 && randomImage < 1)
    image = loadImage("Bullet1.png");
    else if (randomImage > 1 && randomImage < 2)
    image = loadImage("Bullet2.png");
    else if (randomImage > 2 && randomImage < 3)
    image = loadImage("Bullet3.png");
    else if (randomImage > 3 && randomImage < 4)
    image = loadImage("Bullet4.png");
    else if (randomImage > 4 && randomImage < 5)
    image = loadImage("Bullet5.png");
    else if (randomImage > 5 && randomImage < 6)
    image = loadImage("Bullet6.png");
    x = mouseX + 20;
  }
  void move()
  {
    y -= dy;
  }
  void draws() {
    //fill(int(random(0,255)),int(random(0,255)),int(random(0,255)));
    //ellipse(x, y, radius, radius); 
    image(image, x, y);
  }
}
