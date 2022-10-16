class Player {
  float xpos, ypos;
  PImage image;
  Player(PImage currentImage)
{
  image = currentImage;
  image = loadImage("JET.png");
}
  void draw()
  {
    ypos = height - 70;
    xpos = mouseX;
    image(image,xpos,ypos);
  }
}
