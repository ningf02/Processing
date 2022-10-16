int i;
int j;
void setup(){
size(200, 200);
noStroke(); 
i=0;
}
void draw(){
background(51);
fill(255, 204, 0);
rect(i, 20, 50, 50);
if(i++>=199) i=0;

fill(255, 204, 0);
rect(j, 20, 50, 50);
if(j++>=0) j=-199;
}
