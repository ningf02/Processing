

class Widget {

  float x, y;
  float w, h;
  float origY ;

  private int action;
  boolean clicked = false;

  private color bgColor = color(100);
  private color bgHighlight = color(200);

  private color borderColor = color(150);
  private color borderHighlight = color(0);

  int borderWidth = 2;
  float tSize = width/100;
  String text = "";
  color textColor = color(0);

  Widget(float x, float y, float w, float h, int a) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.action = a;
    origY = y;
  }

  Widget(float x, float y, float w, float h, int a, String t) {
    this(x, y, w, h, a);
    this.text = t;
  }

  void setBGColor(int r, int g, int b) {
    bgColor = color(r, g, b);
  }

  void setBGHighlight(int r, int g, int b) {
    bgHighlight = color(r, g, b);
  }

  void setBorderColor(int r, int g, int b) {
    borderColor = color(r, g, b);
    borderHighlight = color(r, g, b);
  }

  void setBorderHighlight(int r, int g, int b) {
    borderHighlight = color(r, g, b);
  }

  boolean getClicked() {
    return clicked;
  }

  void display() {
    if (isMouseOverRect(x, y, w, h)) {
      stroke(borderHighlight);
      fill(bgHighlight);
      if (justPressed) {
        clicked = true;
      } else clicked = false;
    } else {
      stroke(borderColor);
      fill(bgColor);
    }

    strokeWeight(borderWidth);
    rect(x, y, w, h);
    fill(textColor);
    textAlign(CENTER, LEFT);
    textSize(tSize);
    fill(textColor);
    text(text, (x+w/2), (y + tSize));
  }
}

boolean isMouseOverRect(float x, float y, float w, float h) {
  if (mouseX > x && mouseX< x+w) {
    if (mouseY > y && mouseY < y+h) {
      return true;
    }
  }
  return false;
}
