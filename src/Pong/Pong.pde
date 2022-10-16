Player computerPlayer;
Player thePlayer;
Ball theBall;
PFont myFont;

void settings(){
size(SCREENX, SCREENY);
}

void setup(){
myFont = loadFont("AcademyEngravedLetPlain-18.vlw");
textFont(myFont);
computerPlayer = new Player(MARGIN);
thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
theBall = new Ball();
ellipseMode(RADIUS);

}
void draw() {
background(255, 255, 204);
thePlayer.move(mouseX);
computerPlayer.autoMove(int(theBall.x));
theBall.move();
theBall.collide(thePlayer, computerPlayer);
computerPlayer.draw();
thePlayer.draw();
theBall.draw();
theBall.reset();



}
