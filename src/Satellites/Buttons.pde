int buttonX, buttonY;      // Position of buttons
int buttonWidth;
int buttonHeight;
color buttonColor, baseColor;
color buttonHighlight;
boolean singleViewPressed = false;
boolean barchartViewPressed = false;
boolean drawCountryChart = false;
boolean drawStatusChart = false;

//Button Settings
void buttonSettings() {
  buttonColor = color(150, 150, 150);
  buttonHighlight = color(100);

}

//satellite orbit view button
boolean overSingleViewButton(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

//barchart view button
boolean overBarchartButton(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean isBackButtonPressed(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width &&
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}


//back buttons
void backButton() {
  tint(150);
  image(backButton, width- exitButtonSize*2.2, 0, exitButtonSize, exitButtonSize);
}

//updating buttons
void updateButtons() {
  if (overBarchartButton(buttonX, buttonY, buttonWidth, buttonHeight) ) {
    barchartViewPressed = true;
    singleViewPressed = false;
  } else if (overSingleViewButton(buttonX, buttonY, buttonWidth, buttonHeight) ) {
    singleViewPressed = true;
    barchartViewPressed = false;
  } else {
    barchartViewPressed = singleViewPressed = false;
  }
}


//ControlP5 Events -> Radio Button, Search Bar
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(r1)) {
    //println("Status Chart: " + theEvent.arrayValue()[0]);
    //println("Country Chart: " + theEvent.arrayValue()[1]);
    if ((theEvent.getGroup().getArrayValue()[0]) == 1 ) {
      drawStatusChart = true;
      drawCountryChart = false;
    }
    if (theEvent.getGroup().getArrayValue()[1] == 1) {
      drawCountryChart = true;
      drawStatusChart = false;
    }

    if (theEvent.getGroup().getArrayValue()[0] == 0 && theEvent.getGroup().getArrayValue()[1] == 0) {
      drawCountryChart = false;
      drawStatusChart = false;
    }
  }
} 
