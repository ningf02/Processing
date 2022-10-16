int i;
int j;
int z;
void setup(){
size(200, 200);
noStroke(); 
i=40; j=60; z=70;
}
void draw(){
background(51);

fill(0, 102, 255);
rect(i, 20, 50, 50);
if(i++>=199) i=199;

fill(255, 80 ,80);
rect(j, 40, 50, 50);
if(j--<=-50) j=-50;

fill(153, 255, 51);
rect(80, z, 50, 50);
if(z++>=199) z=199;

}
