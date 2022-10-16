float x, y, voltageX, voltageY;
float diam = 10;
float rectSize = 150;
Player player;

int scoreLeft = 0;
int scoreRight = 0;
int f = 0;
int speed = 1;
int time = 0;

void setup() {
  size(500, 500);
  fill(0, 200, 0);
  reset();
  player = new Player(0);
  player.voltageY = 1;
}

void reset() {
  f = 0;
  time = 0;
  x = width/2;
  y = height/2;
  voltageX = 2;
  voltageY = 2;
}

void draw() { 
  background(0);
  player.display(); 
  player.move(); 
  player.display(); 
  if(time == 0 && player.voltageY < 0) {
      player.voltageY = -1;
  }
  if(time == 0 && player.voltageY > 0) {
      player.voltageY = 1;
  }
  
  time += 1;
  if(time > 101){
    time -= 100;
    voltageX += 0.25;
    voltageY += 0.25;
    if(player.voltageY < 0) {
      player.voltageY -= 1;
    }
    if(player.voltageY > 0) {
      player.voltageY += 1;
    }
  }
  
  ellipse(x, y, diam, diam);

  rect(width-30, mouseY-rectSize/2, 10, rectSize);

  x += voltageX;
  y += voltageY;
  
  if(player.top() > y && player.voltageY > 0){
    player.voltageY *= -1;
  }
  if(player.bottom() < y && player.voltageY < 0) {
    player.voltageY *= -1;
  }
  if ( x > width-30 && x < width -20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
    voltageX = voltageX * -1;
  } 
  if( x > width + 20 && f == 0)
  {
    scoreLeft += 1;
    f = 1;
  }

  if ( x < 10 && x > -10 && player.top() < y && player.bottom() > y) {
    voltageX *= -1.2;
    voltageY *= 1.2;
    x += voltageX;
  }
  if( x < -20 && f == 0)
  {
    scoreRight += 1;
    f = 1;
  }
  println(player.top(), "           ", y, "             ", player.voltageY, "        ", time);


  // if ball hits up or down, change direction of Y   
  if ( y > height || y < 0 ) {
    voltageY *= -1.2;
  }
  
  textSize(20);
  textAlign(CENTER);
  text(scoreRight, width/2+30, 30); 
  text(scoreLeft, width/2-30, 30);
  text("Ball Speed: " + voltageX, width/2, 80);
  if(scoreLeft == 3){
    text("Game Over", width/2, height/2); 
  }
  if(scoreRight == 3){
    text("You Win", width/2, height/2); 
  }
}

void mousePressed() {
  reset();
}
class Player {
  float y;
  float voltageY;
  int c;
  
  Player(float tempY){
    y = tempY;
    voltageY = 0;
    c=200;
  }

  void move(){
    y += voltageY;
  }
  void display() {
    fill(0,c,0); 
    rect(0, y, 10, rectSize);
  }
  float top(){
    return y;
  }
  float bottom(){
    return y+rectSize;
  }
}
