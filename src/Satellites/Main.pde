String[] lineData; //<>// //<>//

import controlP5.*;
ControlP5 cp5;
ControlP5 radioButton;
RadioButton r1;


ArrayList<String[]> satellites;
String[] tags;
IntList indexesToPrint;

PImage backButton;

int screen = 0;

PFont stdFont;
PFont enlargedFont;
PFont smallFont;
int exitButtonSize;

// For the Single View
PImage earthTexture;
PShape globe;
float globeRadius;
float angle = 0;
Screen singleViewScreen;
int numberOfSatellites = 40;
float buttonMargin;
int satelliteIndex = -1;


Widget exitButton;


float scale;

boolean keyReleased = false;
boolean justPressed = false;

ArrayList<Satellite> mainSatellites;

int n = 400;

PVector pivot;

void setup() {

  mainSatellites = new ArrayList<Satellite>();
  pivot = new PVector(width/2, height/2);
  for (int i = 0; i < n; i++) {
    mainSatellites.add(new Satellite(pivot, width/6, i));
  }


  buttonWidth = width/8;
  buttonHeight = height/20;
  buttonX = width/3;
  buttonY = height/8;
  scale = width/50000f;

  backButton = loadImage("back.png");
  buttonMargin =  width/50f;
  fullScreen(P3D);
  exitButtonSize = width/50;
  buttonSettings();

  //Initializing buttons
  exitButton = new Widget(width - exitButtonSize, 0, exitButtonSize, exitButtonSize, NONE, "X");
  exitButton.setBGColor(255, 0, 0);
  exitButton.setBGHighlight(255, 0, 0);
  exitButton.setBorderColor(255, 0, 0);
  exitButton.setBorderHighlight(255, 0, 0);

  // Importing data
  lineData = loadStrings("gcat10k.tsv");
  satellites = new ArrayList<String[]>();
  tags = lineData[0].split("\t");
  for (int i = 0; i < lineData.length; i++) {
    String[] currentLine = lineData[i].split("\t");
    satellites.add(currentLine);
  }

  // Setting up font size
  float fontSize = width/100;
  stdFont = createFont("Arial", fontSize);
  textFont(stdFont, fontSize);
  enlargedFont = createFont("Arial", fontSize*2);
  smallFont = createFont("Arial", fontSize/1.5);


  //Setting up search bar
  //cp5 = new ControlP5(this);
  //cp5.addTextfield("Search")
  //  .setPosition(width - 240, 20)
  //  .setSize(180, 20)
  //  .setAutoClear(false);


  //Setting up radio button for bar charts
  radioButton = new ControlP5(this);

  radioButton.setFont(smallFont);
  r1 = radioButton.addRadioButton("Bar chart picker")
    .setPosition(width -350, 40)
    .setSize(30, 30)
    .setSpacingRow(15)
    .setColorForeground(#02c39a)
    .setColorActive(#00a896)
    .setColorLabel(#02c39a)
    .setColorBackground(#05668d)
    .addItem("Number of Satellites By Status Code", 1)
    .addItem("Number of Satellites By Country", 2);

  // Loading texture for single view
  earthTexture = loadImage("earthtexture.jpg");
  noStroke();
  //stroke(255);
  noFill();
  globeRadius = EARTH_RADIUS*scale;
  globe = createShape(SPHERE, globeRadius);
  globe.setTexture(earthTexture);

  singleViewScreen = new Screen();
  singleViewScreen.setSlider(new Slider(width-width/100, 0, width/100, height));


  for (int i = 1; i < numberOfSatellites; i++) {
    String displayText = satellites.get(i)[NAME];
    Widget w = new Widget(buttonMargin, i*buttonMargin+buttonMargin*5, width-buttonMargin*2, buttonMargin, i, displayText);
    w.textColor = color(255);
    w.setBGColor(0, 0, 0);
    w.setBGHighlight(100, 100, 100);
    w.setBorderColor(255, 255, 255);

    singleViewScreen.add(w);
  }
  singleViewScreen.input = new Input(width/3, height/9, width/3, height/25);
  countryIndexes();
}

void draw() {
  if (keyPressed) keyReleased = false;
  background(0);

  //HOME SCREEN
  if (screen == HOME_SCREEN) {
    background(0);
    singleViewScreen.slider.value = 0;
    updateButtons();
    homeScreen();
    r1.setVisible(false);
    int chosen = -1;
    pushMatrix();

    angle+=0.003;

    translate(pivot.x, pivot.y);
    rotateY(angle);
    shape(globe);
    popMatrix();
    for (int i = 0; i < mainSatellites.size(); i++) {
      Satellite s = mainSatellites.get(i);
      if (chosen == -1) chosen = s.display();
      else s.display();
    }

    if (chosen > -1) {
       screen = SINGLE_VIEW; 
       satelliteIndex = chosen;
    }
    
    //SINGLE VIEW
  } else if (screen == SINGLE_VIEW) {
    backButton();

    if (satelliteIndex > -1) {
      singleView(satelliteIndex);
    } else {
      satelliteIndex = singleViewScreen.display();
    }

    //BAR CHARTS VIEW
  } else if (screen == BAR_CHART_VIEW) {
    r1.setVisible(true);
    background(#002642);
    backButton();

    if (drawStatusChart) {
      barChartScreen();
      backButton();
    }
    if (drawCountryChart) {
      barChartScreen2();
      backButton();
    }
  }


  exitButton.display();
  if (exitButton.getClicked()) {
    exit();
  }


  if (justPressed)
    justPressed = false;
}

void mousePressed() {
  if (!justPressed) justPressed = true;
  if (mouseX > width - exitButtonSize*2 && mouseX < width-exitButtonSize) {
    if (mouseY < exitButtonSize && mouseY > 0) {
      singleViewPressed = false;
      barchartViewPressed = false;
      screen = HOME_SCREEN;
      satelliteIndex = -1;
    }
  }
  if (isMouseOverRect(buttonX-buttonWidth/2, buttonY-buttonHeight/2, buttonWidth, buttonHeight) && screen==HOME_SCREEN) {
    screen = SINGLE_VIEW;
  }
  if (isMouseOverRect(buttonX-buttonWidth/2+width/3, buttonY-buttonHeight/2, buttonWidth, buttonHeight) && screen == HOME_SCREEN) {
    screen = BAR_CHART_VIEW;
    satelliteIndex = -1;
  }
}

void keyPressed() {
  keyReleased = false;
}

void keyReleased() {
  keyReleased = true;
}

void mouseReleased() {
}

void mouseDragged() {
  if (screen == BAR_CHART_VIEW) {
    if (mouseY <= sliderYPosition + sliderHeight && mouseY >= sliderYPosition) {
      if (mouseX >= sliderMinPosition && mouseX <+ sliderMinPosition + sliderWidth) {
        sliderMinPosition = mouseX - sliderWidth / 2;
        // maxValue = 0;
      }
      if (mouseX >= sliderMaxPosition && mouseX <+ sliderMaxPosition + sliderWidth) {
        sliderMaxPosition = mouseX - sliderWidth / 2;
        // maxValue = 0;
      }
        if (sliderMinPosition < width / 25)
          sliderMinPosition = width / 25;
        if (sliderMaxPosition > width / 25 + (width - 2.5 * width / 25))
          sliderMaxPosition = width / 25 + (width - 2.5 * width / 25);
    }
  }
}
