class Ball {
float x; float y;
float dx; float dy;
int radius;
int w = 0;
int l = 0;
color ballColor = color(0);
Ball(){
x = random(SCREENX/4, SCREENX/2);
y = random(SCREENY/4, SCREENY/2);
dx = random(6, 7); dy = random(6, 7);
radius=7;
}

void move(){
x = x+dx; y = y+dy;
}
void draw(){
fill(ballColor);
ellipse(x,y, radius, radius);

if(y-radius>=SCREENY) w++;
  if(w==3) 
  text("TRY AGAIN!", 200, 240);
  
  if(y<=0) l++;
  if(l==3)
  text("YOU WON!", 200, 240);
}


void collide(Player hp, Player cp){
if(x-radius <= 0) dx=-dx;
else if(x+radius>=SCREENX) dx=-dx;

if(y+radius >= hp.ypos &&
y-radius<hp.ypos+PADDLEHEIGHT &&
x >=hp.xpos && x <=
hp.xpos+PADDLEWIDTH )
dy=-dy;

if(y+radius >= cp.ypos &&
y-radius<cp.ypos+PADDLEHEIGHT &&
x >=cp.xpos && x <=
cp.xpos+PADDLEWIDTH )
dy=-dy;
}





  void reset(){
  if ( y-radius>=SCREENY || y<=0){
    theBall.x = (SCREENX/2);
    theBall.y = (SCREENY/2);
    dx=0;
    dy=0;
  }
  if(mousePressed){
    dx=random(6,7);
    dy=random(6,7);
}
                               
  }

}
