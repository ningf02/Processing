float x,y;
int f;
int count = 0, countdead = 0;
int gameOver;
PImage image;
Alien[] aliens = new Alien[17];
Bullet[] bullet = new Bullet[5000];
Player thePlayer;

void setup(){
  size(1000, 700);
  init_aliens(aliens);
  thePlayer = new Player(image);
}

void init_aliens (Alien[] object){
  for(int i = 0; i < aliens.length; i++)
  {
     object[i] = new Alien(i);
     object[i].dx = 10;
  }
}

void draw(){
  int j;
  background(204, 255, 255);
  for(int i = 0; i < aliens.length; i++)
  {
    aliens[i].loop += 1;
    aliens[i].draw();
    aliens[i].move();
    if(aliens[i].loop == aliens[i].random)
    {
      aliens[i].bomb = new Bomb(aliens[i].x, aliens[i].y, image);
    }
    if(aliens[i].loop >= aliens[i].random)
    {
      aliens[i].bomb.draw();
      aliens[i].bomb.move();
      if(aliens[i].bomb.y > aliens[i].random + 800 && aliens[i].dead == false)
      {
        aliens[i].bomb.x = aliens[i].x;
        aliens[i].bomb.y = aliens[i].y;
      }
      if(aliens[i].bomb.collide(thePlayer) == true)
      {
        gameOver = 1;
      }
    }
    for(j = 0; j < count; j++)
    {
      aliens[i].collidex = bullet[j].x;
      aliens[i].collidey = bullet[j].y;
      aliens[i].explode();
    }  
  }
  countdead = 0;
  for(int i = 0; i < aliens.length; i++)
  {
    if(aliens[i].dead == true) 
    countdead++;
  }
  if(countdead >= aliens.length) 
  gameOver = 2;
  thePlayer.draw();
  for(int i = 0; i < count; i++)
  {
    bullet[i].draws();
    bullet[i].move();
  }
  if(gameOver == 1)
  {
    textSize(50);
    textAlign(CENTER);
    fill(int(random(0,255)),int(random(0,255)),int(random(0,255)));
    text("Game Over", width/2, height/2);
    frameRate(0);
  }
  else if(gameOver == 2)
  {
    textSize(50);
    textAlign(CENTER);
    fill(int(random(0,255)),int(random(0,255)),int(random(0,255)));
    text("You Won", width/2, height/2);
    frameRate(0);
  }
}
void mousePressed()
{
  bullet[count] = new Bullet(mouseX, image);
  bullet[count].dy = 5;
  bullet[count].y = height-70;
  count += 1;
}
