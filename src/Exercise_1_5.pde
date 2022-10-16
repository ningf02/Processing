int i;
int x;
int y;
float a;
void setup(){
size(400, 400);
noStroke();
a=20; i=0; x=0; y=0;
frameRate(40);
}
void draw(){

  background(51);
  fill(255, x, 0); 
 
   rect(i, 200+sin(a/10)*100.0, 50, 50); 
   rect(i-400, 200+sin(a/10)*100.0, 50, 50); 
  a=a+1;
if (i++>=400) i=0;

if(y==0) x++;
if(x>=255) y=1;
if(y==1) x--;
if(x<=0) y=0;
}
