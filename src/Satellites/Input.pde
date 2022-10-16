

class Input {

  boolean selected = false;
  boolean justInputted = false;
  float maxLength = 30;
  public String value = "";
  float x, y, w, h;
  float textSize;
  String label = "Search";
  Input(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    textSize = h*.7;
  }

  void display() {
    if (keyReleased) justInputted = false;
    if (isMouseOverRect(x, y, w, h) && mousePressed) {
      selected =true;
    }
    if (!isMouseOverRect(x, y, w, h) && mousePressed) {
      selected = false;
    }
    if (selected && !keyPressed) {
      justInputted = false;
    }
    if (selected && keyPressed) {
      if (key != ENTER) {

        if (key == BACKSPACE && value.length()>0 &&!justInputted) {

          value = value.substring(0, value.length()-1);
        } else if (value.length() < maxLength && key != BACKSPACE && !justInputted) {
          justInputted = true;
          value += key;
        }
      }
    }

    fill(255);
    noStroke();
    rect(x, y, w, h, w/10.0);

    textSize(textSize);
    textAlign(LEFT, CENTER);
    if (value.length()>0) {
      fill(0);
      text(value, x+textSize, y+h/2);
    } else {
      fill(150);
      text(label, x+textSize, y+h/2);
    }
  }
}
