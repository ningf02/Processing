void printDataToConsole(ArrayList<String[]> satellites, int numberOfSatellites, int...tags) { //<>// //<>// //<>//
  for (int i = 0; i < numberOfSatellites; i++) {
    for (int j = 0; j < tags.length; j++) {
      int tag = tags[j];
      print(satellites.get(i)[tag] + " ");
    }
    println();
  }
}

void printDataToScreen(ArrayList<String[]> satellites, int numberOfSatellites, int...tags) {
  for (int i = 0; i < numberOfSatellites; i++) {
    for (int j = 0; j < tags.length; j++) {
      int tag = tags[j];
      textFont(stdFont);
      textSize(20);
      fill(255);
      text(satellites.get(i)[tag], (j + 1) * 300, (i + 1) * 50);
    }
  }
}


void printStatusBarGraph(IntList indexes) {
  textFont(enlargedFont);
  textAlign(CENTER);
  fill(204, 0, 0);
  text("Status Flags of Satellites", width/2, 100);
  textAlign(LEFT);
  fill(255);
  String[] status = new String[11];
  String[] statusLegend = new String[11];
  int[] freqStatus = new int[11];

  status[0] = "AO";
  status[1] =  "AR";
  status[2] = "D";
  status[3] =  "DSO";
  status[4] = "E";
  status[5] = "L";
  status[6] = "N";
  status[7] = "O";
  status[8] = "OX";
  status[9] = "R";
  status[10] = "R?";

  statusLegend[0] = "Attached in Orbit"; //[A0]
  statusLegend[1] = "Reentered Attached"; //[AR]
  statusLegend[2] = "Deorbited"; //[D]
  statusLegend[3] = "Deep Space"; //[DSO]
  statusLegend[4] = "Exploded"; //[E]
  statusLegend[5] = "Landed"; // [L]
  statusLegend[6] = "Renamed"; //[N]
  statusLegend[7] = "In orbit"; //[O]
  statusLegend[8] = "Lost";  //[OX]
  statusLegend[9] = "Reentered"; //[R]
  statusLegend[10] = "Reentered?"; //[R?]

  for (int i = 0; i < indexes.size(); i++) {
    switch (satellites.get(indexes.get(i))[STATUS]) {
    case "AO":
      freqStatus[0]++;
      break;
    case "AR":
      freqStatus[1]++;
      break;
    case "D":
      freqStatus[2]++;
      break;
    case "DSO":
      freqStatus[3]++;
      break;
    case "E":
      freqStatus[4]++;
      break;
    case "L":
      freqStatus[5]++;
      break;
    case "N":
      freqStatus[6]++;
      break;
    case "O":
      freqStatus[7]++;
      break;
    case "OX":
      freqStatus[8]++;
      break;
    case "R":
      freqStatus[9]++;
      break;
    case "R?":
      freqStatus[10]++;
      break;
    default :
      // print("Error in status");
    }
  }

  // text("Legends:", width/50, 40);

  maxValue = maxValue(freqStatus);
  for (int i = 0; i < freqStatus.length; i++) {
    textFont(stdFont);
    // print Legend
    int xLegend = width/50;
    int margin = (i*30) + height/50;
    text(status[i] + " = " + statusLegend[i], xLegend, margin + 30);
    // prints bar charts
    int spacing = width/15;
    int barChartWidth = width/22;
    int y = height/13;
    if (maxValue != 0){
    float h = map(freqStatus[i], 0, maxValue, 0, height*.75);
    rect(i * 2 * barChartWidth + barChartWidth/2, height - h - height/10, barChartWidth, h, 5);
    textAlign(CENTER);
    text(str(freqStatus[i]), i * 2 * barChartWidth + barChartWidth, height - height/9 - h);
    }
    textAlign(CENTER);
    text(status[i], i * 2 * barChartWidth + barChartWidth, height - y);
    textAlign(LEFT);
  }

    //sliders to select range of mass
    if (sliderMaxPosition == 0) {
        sliderMinPosition = width / 25;
        sliderMaxPosition = width / 25 + (width - 2.5 * width / 25);
        sliderYPosition = height - height / 20;
        sliderWidth = width / 50;
        sliderHeight = height / 25;
    }
    if (sliderMinPosition == sliderMaxPosition) {
      sliderMinPosition -= sliderWidth;
      sliderMaxPosition += sliderWidth;
    }
    rect(width / 25, height - height / 20, width - 2 * width / 25, height / 25);
    fill(0,25, 12);
    rect(sliderMinPosition, sliderYPosition, sliderWidth, sliderHeight);
    rect(sliderMaxPosition, sliderYPosition, sliderWidth, sliderHeight);
    minRange = map(sliderMinPosition, width / 25, width / 25 + (width - 2.5 * width / 25), 0, 105000);
    maxRange = map(sliderMaxPosition, width / 25, width / 25 + (width - 2.5 * width / 25), 0, 105000);
    textAlign(CENTER);
    text("Mass Range: " + str(minRange) + " - " + str(maxRange), width / 2, height - height / 20 + height / 40);
}


//Display Number of Satellites launched by each country
void countrySatellites() {
  updateCountryNumbers();
  background(240);
  fill(#284b63);
  noStroke();
  rect(0, 0, margin, height);
  timer++;
  fill(255);

  pushMatrix();
  float angle = radians(270);
  translate (margin - 50, height/2);
  rotate(angle);
  textAlign(CENTER);
  text("Number of satellites launched by each country/ organisation", 0, 0);
  popMatrix();

  textFont(stdFont);

  textAlign(LEFT);
  fill(255);
  if (timer < 480) {
    perc = max((float(timer)-180)/300, 0);
  } else {
    perc = min(max((float(timer)-480)/300, 0), 1);
    perc = -cos(perc*PI)/2+0.5;
  }
  for (int j = 0; j < 18; j++) {
    fill(colors[j]);
    if (timer < 480) {
      x = int(1040*(start[j]+float(countryNumbers[j])*perc)/maxScore);
      y = 60*unsorted[j];
    } else {
      x = int(1040*(start[j]+countryNumbers[j])/maxScore);
      y = int((unsorted[j]+(float(sorted[j])-float(unsorted[j]))*perc)*60);
    }
    rect(margin, 16+y, x+10, 30);
    textAlign(LEFT);
    text(countryNames[j], margin+x+15, 38+y);
    fill(255);
    textAlign(RIGHT);
    if (timer < 480) {
      text(round((start[j]+countryNumbers[j]*perc)), margin+x, 38+y);
    } else {
      text(start[j]+countryNumbers[j], margin+x, 38+y);
    }
  }
}
int maxValue = 0;
float sliderMaxPosition = 0;
float sliderMinPosition;
float sliderYPosition;
float sliderWidth;
float sliderHeight;
float minRange;
float maxRange;


int[] start = new int[18];
String[] countryNames = new String[18];
int[] countryNumbers = new int[18];
int[] unsorted = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17};
int[] sorted = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17};
boolean[] taken = {false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false};
int timer = 0;
int maxScore = 0;
int x = 0;
int y =0;
int[] colors = new int[18];
int margin = 100;
float perc;

//loading satellites numbers into each country
void countryIndexes() {
  for (int i = 1; i < 10000; i++) {
    switch(satellites.get(i)[STATE]) {
    case "AU":
      countryNumbers[0]++;
      if(countryNames[0] != "Australia") {
        countryNames[0] = "Australia";
        colors[0] = #2e1a4f;
      }
      break;
    case "CA":
      countryNumbers[1]++;
      if(countryNames[1] != "Canada") {
        countryNames[1] = "Canada";
        colors[1] = #54478c;
      }
      break;
    case "CN":
      countryNumbers[2]++;
      if(countryNames[2] != "China") {
        countryNames[2] = "China";
        colors[2] = #2c689a;
      }
      break;
    case "D":
      countryNumbers[3]++;
      if(countryNames[3] != "Germany") {
        countryNames[3] = "Germany";
        colors[3] = #048ba8;
      }
      break;
    case "E":
      countryNumbers[4]++;
      if(countryNames[4] != "Spain") {
        countryNames[4] = "Spain";
        colors[4] = #0db39e;
      }
      break;
    case "F":
      countryNumbers[5]++;
      if(countryNames[5] != "France") {
        countryNames[5] = "France";
         colors[5] = #16db93;
      }
      break;
    case "I":
      countryNumbers[6]++;
      if(countryNames[6] != "Italy") {
        countryNames[6] = "Italy";
         colors[6] = #83e377;
      }
      break;
    case "ID":
      countryNumbers[7]++;
      if(countryNames[7] != "Indonesia") {
        countryNames[7] = "Indonesia";
         colors[7] = #b9e769;
      }
      break;
    case "I-ESA":
      countryNumbers[8]++;
      if(countryNames[8] != "European Space Agency") {
        countryNames[8] = "European Space Agency";
         colors[8] = #efea5a;
      }
      break;
    case "I-ESRO":
      countryNumbers[9]++;
      if(countryNames[9] != "European Space Research Organisation") {
        countryNames[9] = "European Space Research Organisation";
         colors[9] = #f1c453;
      }
      break;
    case "I-INT":
      countryNumbers[10]++;
      if(countryNames[10] != "Intelsat") {
        countryNames[10] = "Intelsat";
         colors[10] = #ffba08;
      }
      break;
    case "IN":
      countryNumbers[11]++;
      if(countryNames[11] != "India") {
        countryNames[11] = "India";
         colors[11] = #ffa307;
      }
      break;
    case "I-NATO":
      countryNumbers[12]++;
      if(countryNames[12] != "North Atlantic Treaty Organisation") {
        countryNames[12] = "North Atlantic Treaty Organisation";
         colors[12] = #f48c06;
      }
      break;
    case "J":
      countryNumbers[13]++;
      if(countryNames[13] != "Japan") {
        countryNames[13] = "Japan";
         colors[13] = #e85d04;
      }
      break;
    case "NL":
      countryNumbers[14]++;
      if(countryNames[14] != "Netherlands") {
        countryNames[14] = "Netherlands";
         colors[14] = #dc2f02;
      }
      break;
    case "SU":
      countryNumbers[15]++;
      if(countryNames[15] != "Soviet Union") {
        countryNames[15] = "Soviet Union";
         colors[15] = #d00000;
      }
      break;
    case "UK":
      countryNumbers[16]++;
      if(countryNames[16] != "United Kingdom") {
        countryNames[16] = "United Kingdom";
         colors[16] = #9d0208;
      }
      break;
    case "US":
      countryNumbers[17]++;
      if(countryNames[17] != "United States") {
        countryNames[17] = "United States";
         colors[17] = #6a040f;
      }
      break;
    }
    //println(countryNumbers);
  }
}


//Method to arrange countries from most satellites launched to least satellites launched
void updateCountryNumbers() {
  for (int i = -1; i < 18; i++) {
    int record = 0;
    int recordHolder = 0;
    for (int j = 17; j >= 0; j--) {
      if (start[j] >= record && !taken[j]) {
        record = start[j];
        recordHolder = j;
      }
    }
    taken[recordHolder] = true;
    unsorted[recordHolder] = i;
  }
  for (int i = 0; i < 18; i++) {
    taken[i] = false;
  }
  for (int i = 0; i < 18; i++) {
    int record = 0;
    int recordHolder = 0;
    for (int j = 17; j >= 0; j--) {
      if (start[j]+countryNumbers[j] >= record && !taken[j]) {
        record = start[j]+countryNumbers[j];
        recordHolder = j;
      }
    }
    taken[recordHolder] = true;
    sorted[recordHolder] = i;
    if (i == 0) maxScore = record;
  }
}
int maxValue(int[] freqStatus){
  int value = 0;
  for(int i = 0; i < freqStatus.length; i++){
    if (value < freqStatus[i])
      value = freqStatus[i];
  }
  return value;
}
