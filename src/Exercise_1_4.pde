int i;
int j;
int x;
int y;
void setup(){
size(200, 200);
noStroke();
i=0; j=-200; x=150; y=350;
}
void draw(){
background(51);
fill(255, 204, 0);
rect(i, 20, 50, 50);
if(i++>=200) i=0;

fill(255, 204, 0);
rect(j, 20, 50, 50);
if(j++>=0) j=-200;

fill(204, 102, 255);
rect(x, 100, 50, 50);
if(x--<=-50) x=150;

fill(204, 102, 255);
rect(y, 100, 50, 50);
if(y--<=150) y=350;
}
