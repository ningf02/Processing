class Player {
int xpos; int ypos;


color paddlecolor = color(255, 102, 153);
Player(int screenY)
{
xpos=SCREENX/2;
ypos=screenY;
}

void move(int x){
if(x>SCREENX-PADDLEWIDTH) xpos = SCREENX-PADDLEWIDTH;
else xpos=x;
}

void autoMove(int ballx){
  if(xpos+PADDLEWIDTH/2 < ballx)
  xpos+=6;
  else 
  xpos-=6;
}
  
void draw()
{
fill(paddlecolor);
rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
}


}
