class SpaceData {
  String jCAT;
  int satcat;
  String piece;
  String type;
  String name;
  String pLName;
  String lDate;
  String parent;
  String sDate;
  String primary;
  String dDate;
  String status;
  String dest;
  String owner;
  String state;
  String manufacturer;
  String bus;
  String motor;
  int mass;
  String massFlag;
  int dryMass;
  String dryFlag;
  int totMass;
  String totFlag;
  double length;
  String lFlag;
  double diameter;
  String dFlag;
  double span;
  String spanFlag;
  String shape;
  String oDate;
  int perigee;
  String pF;
  int apogee;
  String aF;
  double inc;
  String iF;
  String opOrbit;
  String oQUAL;
  String altNames;

  SpaceData() {
    // String[] lineData = loadStrings(fileName);
    // println(lineData[0]);
  }
}

void printDataToConsole(SpaceData[] spaceData) {
  for (int i = 0; i < spaceData.length/4; i++) {
    println("Name: " + spaceData[i].name
      + "  Launch Date: " + spaceData[i].lDate );
  }
}

void printDataToScreen(SpaceData[] spaceData) {
  for (int i = 0; i < spaceData.length; i++) {
    textFont(stdFont);
    textSize(20);
    fill(255);
    text(spaceData[i].name, 300, (i+1) * 50);
  }
}

IntList getRangeOfMass(ArrayList<String[]> satellites, double rangeFrom, double rangeTo) {
  IntList indexInRange = new IntList();
  for (int i = 1; i < satellites.size(); i++) {
    if (Double.valueOf(satellites.get(i)[MASS]) >= rangeFrom && Double.valueOf(satellites.get(i)[MASS]) <= rangeTo) {
      indexInRange.append(i);
    }
  }
  return indexInRange;
}
