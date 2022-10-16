class Slider extends Widget {

  float value = 0;
  color sliderColor = color(150);
  color thumbColor = color(55);
  float thumbHeight;
  
  
  boolean caught = false;

  Slider(float x, float y, float w, float h) {
    super(x, y, w, h, NONE);
    thumbHeight = h*.1;
  }
  
  @Override
  void display() {
    value = clamp(value, 0, 10);
    float thumbY = map(value, 0, 10, y, y+h);
    if (!isMouseOverRect(x,thumbY, w, thumbHeight) && !mousePressed) {
     caught = false; 
    }
    if (isMouseOverRect(x,thumbY, w, thumbHeight) && mousePressed) {
      caught = true;
    }
      noStroke();
    fill(sliderColor);
    rect(x, y, w, h);
    fill(thumbColor);

    rect(x, thumbY, w, h*.1);
    
    if (caught) {
      value = map(mouseY-thumbHeight/2, y, y+h+thumbHeight/2, 0, 10.0);
    }
  }
}

float clamp(float x, float min, float max) {
  if (x<min) return min;
  if (x>max) return max;
  return x;
}
