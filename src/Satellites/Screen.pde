class Screen {
  String lastSearch = "";
  ArrayList<Widget> buttons = new ArrayList<Widget>();
  Slider slider = null;
  Input input = null;

  Screen() {
  }

  void add(Widget button) {
    buttons.add(button);
  }

  void setSlider(Slider slider) {
    this.slider = slider;
  }

  //returns index of buttons clicked
  int display() {
    String search = null;
    int index = -1;

    if (input!=null) {
      input.display();
      search = input.value;
    }

    if (search != null && !lastSearch.equalsIgnoreCase(search)) {
      lastSearch = search;
      buttons.clear();
      ArrayList<Integer> searchIndices = new ArrayList<Integer>();
      int counter = 0;
      for (int j = 1; j < satellites.size(); j++) {
        String part = satellites.get(j)[NAME].substring(0, min(search.length(), satellites.get(j)[NAME].length()));
        if (part.equalsIgnoreCase(search)) {searchIndices.add(j); counter++;}
        if (counter > 1000) break;
      }
      //println("Found " + searchIndices.size() + " results!");
      for (int i = 0; i < searchIndices.size(); i++) {
        int searchedIndex = searchIndices.get(i);
        if (index > buttons.size()) continue;
        String displayText = satellites.get(searchedIndex)[NAME];

        Widget w = new Widget(buttonMargin, i*buttonMargin+buttonMargin*5, width-buttonMargin*2, buttonMargin, searchIndices.get(i), displayText);

        w.textColor = color(255);
        w.setBGColor(0, 0, 0);
        w.setBGHighlight(100, 100, 100);
        w.setBorderColor(255, 255, 255);
        this.add(w);
      }
    }

    pushMatrix();
    float translatedY = -map(slider.value, 0f, 10f, 0f, buttonMargin*buttons.size());
    //if (slider != null) translate(0, translatedY);
    for (int i = 0; i < buttons.size(); i++) {
      Widget b = buttons.get(i);
      float h = i*buttonMargin+buttonMargin*5;
      b.y = h + translatedY;
      b.display();
      if (b.clicked) {

        index = b.action;
        b.clicked = false;
      }
    }
    popMatrix();

    if (slider != null) {
      slider.display();
    }

    return index;
  }
}

void homeScreen() {
  textFont(stdFont);
  background(0);
  
  rectMode(CORNER);
  noStroke();
  if (isMouseOverRect(buttonX-buttonWidth/2, buttonY-buttonHeight/2, buttonWidth, buttonHeight)) {
    fill(buttonHighlight);
  } else {
    fill(buttonColor);
  }
  rect(buttonX-buttonWidth/2, buttonY-buttonHeight/2, buttonWidth, buttonHeight, 25);

  if (isMouseOverRect(buttonX-buttonWidth/2+width/3, buttonY-buttonHeight/2, buttonWidth, buttonHeight)) {
    fill(buttonHighlight);
  } else {
    fill(buttonColor);
  }
  rect(buttonX-buttonWidth/2+width/3, buttonY-buttonHeight/2, buttonWidth, buttonHeight, 25);

  fill(255);
  textAlign(RIGHT, CENTER);
  text("Search for a Satellite", buttonWidth/3+buttonX, buttonY);
  text("Visualize the Data", buttonWidth/3f+buttonX+width/3, buttonY);
  rectMode(CORNER);

}

void barChartScreen() {
  background(#002642);
  backButton();
  indexesToPrint = getRangeOfMass(satellites, minRange, maxRange);
  printStatusBarGraph(indexesToPrint);
}

void barChartScreen2() {
  countrySatellites();
}
