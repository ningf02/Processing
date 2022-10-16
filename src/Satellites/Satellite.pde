
class Satellite {
  float angularVelocity;
  float angle;
  float distance;
  PVector pivot;
  PVector position;
  float r;
  int index;
  Satellite(PVector pivot, float d, int i) {
    distance = d + random(d*.1);
    r = width/200f;
    index = i;
    angularVelocity = random(0.001,  0.005);
    this.pivot = pivot;
    angle = random(TAU);
    position = pivot;
  }

  int display() {
    angle += angularVelocity;
    float y = sin(angle) * distance;
    float x = cos(angle) * distance;
    pushMatrix();
    translate(pivot.x, pivot.y);
    fill(255);
    noStroke();

    ellipse(x, y, r, r);
    popMatrix();

    if (dist(x+pivot.x, y+pivot.y, mouseX, mouseY) < r && justPressed) {

       return index;
       
    }
    return -1;
  }
}
