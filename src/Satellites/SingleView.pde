


void singleView(int index) {

  textAlign(LEFT, CENTER);

  String n = satellites.get(index)[NAME];
  String[] querys = n.split(" ");
  String query = "";
  for (String q : querys) {
     query += q + "+"; 
  }
  query += "satellite";
  pushMatrix();
  float yspacing = height/15;
  float xspacing = width/10;
  float margin = height/15;
  for (int j = 0; j < 2; j++) {
    for (int i = 0; i < tagList.length; i++) {
      noFill();
      stroke(255);
      strokeWeight(4);
      rect(j*xspacing+width/50, i*yspacing+margin/2, xspacing, yspacing);
      int tag = tagList[i];
      textFont(stdFont);
      fill(255);
      noStroke();
      String t = j==0 ? satellites.get(0)[tag] : satellites.get(index)[tag];
      text(t, j*xspacing+width/40, i*yspacing+margin);
    }
  }
  
  if (isMouseOverRect(xspacing+width/50, margin/2, xspacing, yspacing)) {
    fill(150, 150, 150, 100);
    rect(xspacing+width/50, margin/2, xspacing, yspacing);
    if (justPressed) {
      link("https://google.com/search?q=" + query); 
    }
   
  }


  translate(2*width/3, height/2);

  //Drawing Ellipse of satellite
  pushMatrix();
  rotateX(-.5);
  angle+=0.003;
  rotateY(angle);
  noStroke();
  lights();
  shape(globe);
  popMatrix();

  //Drawing satellite ellipse
  float apogee, perigee;
  try {
  apogee = Float.parseFloat(satellites.get(index)[APOGEE]);
  perigee = Float.parseFloat(satellites.get(index)[PERIGEE]);
  } catch (Exception e) {
   apogee = 200;
   perigee = 150;
  }
  float ellipseWidth = (apogee + perigee + EARTH_RADIUS * 2) * scale;
  float ellipseHeight = ((apogee + perigee)/2 + EARTH_RADIUS * 2) * scale;
  pushMatrix();

  rotateX(10.26);
  rotateY(1);
  noFill();
  stroke(255);
  strokeWeight(5);
  ellipse(0, 0, ellipseWidth, ellipseHeight);

  float x = (ellipseWidth/2) * cos(angle*4);
  float y = (ellipseHeight/2) * sin(angle*4);
  fill(0, 255, 0);
  noStroke();
  //ellipse(x, y, width/200, width/200);
  translate(x, y);
  sphere(width/200);
  popMatrix();
  popMatrix();
}
