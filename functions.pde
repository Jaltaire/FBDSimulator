void physicsSetup() { //Performs physics calculations and readjusts force magnitudes and directions as needed.
  
  if (leftForce == true) {
  
    leftForceMagnitudeX = tempXL - (blockX - blockWidth/2);
    leftForceMagnitudeY = tempYL - blockY;
  
    fL = -sqrt(pow(leftForceMagnitudeX, 2) + pow(leftForceMagnitudeY, 2));
      
  }
  
  if (rightForce == true) {
  
    rightForceMagnitudeX = tempXR - (blockX + blockWidth/2);
    rightForceMagnitudeY = tempYR - blockY;
  
    fR = sqrt(pow(rightForceMagnitudeX, 2) + pow(rightForceMagnitudeY, 2));
      
  }
    
  if (abs(leftForceMagnitudeX) < abs(rightForceMagnitudeX)) fF = (rightForceMagnitudeX + leftForceMagnitudeX);
  if (abs(leftForceMagnitudeX) > abs(rightForceMagnitudeX)) fF = -(rightForceMagnitudeX + leftForceMagnitudeX);
  if (abs(leftForceMagnitudeX) == abs(rightForceMagnitudeX)) fF = 0;
  
  if (abs(fF) >= coefFriction * fN) fF = coefFriction * fN;
    
  if (fN == 0) fF = 0;
    
  if (coefFriction <= 0) frictionForce = false;
  
  //println(leftForceMagnitudeX, rightForceMagnitudeX);
  
  gravity = new VectorArrow(blockX, blockY, blockX, blockY - fG, "G", 20, 0, false);
  if (normalForce) normal = new VectorArrow(blockX, (blockY + blockHeight/2), blockX, blockY - fN, "N", 20, 0, false);
  
  if (leftForce) {
    left = new VectorArrow(blockX - blockWidth/2, blockY, tempXL, tempYL, "L", -25, -10, false);
  }
  
  if (rightForce) {
    right = new VectorArrow(blockX + blockWidth/2, blockY, tempXR, tempYR, "R", 25, -10, false);
  }
  
  if (rightForceMagnitudeX + leftForceMagnitudeX > 0) fF = -fF;
  
  if (fF == 0) frictionForce = false;
  
  if (frictionForce) {
    friction = new VectorArrow(blockX, blockY + blockHeight/2, blockX + fF, blockY + blockHeight/2, "F", 0, 20, false);
  }
  
  fNetX = rightForceMagnitudeX + leftForceMagnitudeX + fF;
  
  rightForceMagnitudeY = -rightForceMagnitudeY;
  leftForceMagnitudeY = -leftForceMagnitudeY;
  
  fG = blockMass * -aG;

  fN = - fG - rightForceMagnitudeY - leftForceMagnitudeY;
  
  
  if (fN < 0 || fN == 0) {
    normalForce = false;
    fN = 0;
  }
  
  if (fN > 0) {
    normalForce = true;
    frictionForce = true;
  }
  
  fNetY = fN + fG + rightForceMagnitudeY + leftForceMagnitudeY;
    
  aX = fNetX/blockMass;
  aY = fNetY/blockMass;
  
  aSys = sqrt(pow(aX, 2) + pow(aY, 2));
  
}

void simulationMetaData() { //Displays title, date, and time information.
  
  d = day();
  m = month();
  y = year();
  
  h = hour();
  min = minute();
  s = second();
  ms = millis();
  
  textAlign(LEFT, CENTER);
  fill(0);
  
  textSize(20);
  text("FBD Simulator", width*.025, height*.05);
  
  textSize(12);
  text(m + "/" + d + "/" + y, width*.025, height*.1);
  text(h + ":" + min + ":" + s + ":" + ms, width*.025, height*.13);
  
}

void directions() { //Provides user directions for keyboard input.
  
  textAlign(LEFT, CENTER);
  fill(0);
  
  textSize(12);
  //text("Press N to begin a new simulation. (Resets all forces and block position.)", width*.45, height*.05);
  
  if (moveLeft) {
    fill(0, 255, 0);
    text("Press L to disable drawing of the left applied force.", width*.45, height*.075);
  }
  
  if (!moveLeft) {
    fill(255, 0, 0);
    text("Press L to enable drawing of the left applied force.", width*.45, height*.075);
  }
  
  if (moveRight) {
    fill(0, 255, 0);
    text("Press R to disable drawing of the right applied force.", width*.45, height*.1);
  }
  
  if (!moveRight) {
    fill(255, 0, 0);
    text("Press R to enable drawing of the right applied force.", width*.45, height*.1);
  }
  
}

void ground() { //Generates the ground and adjusts thickness relative to coefficient of friction.
  
  float weight = coefFriction * 5;
  
  if (weight <= 0) weight = 0.005;
  
  strokeWeight(weight);
  stroke(0, groundAlpha);
    
  line(0, blockY + blockHeight/2, width, blockY + blockHeight/2);
    
}

void block() { //Generates the block with assigned coordinates, width, and height.
  
  rectMode(CENTER);
  
  fill(0, 0, 255);
  stroke(0);
  strokeWeight(2);
  
  rect(blockX, blockY, blockWidth, blockHeight);
  
}

void controls() { //Adds control inputs onto control panel for block mass and surface coefficient of friction; provides output to user with GUI for force magnitudes, system accelerations, and angles between forces and horizontal.
  
  innerPanelWidth = 790;
  innerPanelHeight = 110;
  panelCornerRadius = 10;
  
  buttonWidthPos1 = width/2 - innerPanelWidth/2 + 130;
  buttonWidthNeg1 = width/2 - innerPanelWidth/2 + 30;
  
  buttonWidthPos2 = width/2 - innerPanelWidth/2 + 350;
  buttonWidthNeg2 = width/2 - innerPanelWidth/2 + 250;
  
  buttonHeight = height*.85 - innerPanelHeight/2 + 60;
  
  rectMode(CENTER);
  
  fill(205, 201, 201);
  noStroke();
  rect(width/2, height*.85, innerPanelWidth + 10, innerPanelHeight + 10, panelCornerRadius); //Creates the outer panel.

  fill(238, 233, 233);
  noStroke();
  rect(width/2, height*.85, innerPanelWidth, innerPanelHeight, panelCornerRadius); //Creates the inner pannel.
  
  textAlign(CENTER, CENTER);
  fill(0);
  
  //Block Mass Controls
  
  textSize(18);
  text("Block Mass", width/2 - innerPanelWidth/2 + 80, height*.85 - innerPanelHeight/2 + 20);
  
  text(blockMass + " kg", width/2 - innerPanelWidth/2 + 80, height*.85 - innerPanelHeight/2 + 60);
  
  textSize(24);
  
  text("+", buttonWidthPos1, buttonHeight);
  text("-", buttonWidthNeg1, buttonHeight);
  
  if (blockMass < 1) blockMass = 1;
  if (blockMass > 20) blockMass = 20;
  
  //Coefficient of Friction Controls
  
  textSize(18);
  text("Coefficient of Friction", width/2 - innerPanelWidth/2 + 300, height*.85 - innerPanelHeight/2 + 20);
  
  text(coefFriction, width/2 - innerPanelWidth/2 + 300, height*.85 - innerPanelHeight/2 + 60);
  
  textSize(24);
  
  text("+", buttonWidthPos2, buttonHeight);
  text("-", buttonWidthNeg2, buttonHeight);
  
  if (coefFriction < 0.000) coefFriction = 0.000;
  if (coefFriction > 2.000) coefFriction = 2.000;
  
  if (coefFriction <= 0.0025) groundAlpha = 0;
  else groundAlpha = 255;
  
  //Physics Feedback - Force Magnitudes
  
  textAlign(LEFT, CENTER);
  
  float forceNameX = width*.6;
  
  textSize(14);
  text("F  = ", forceNameX, height*.775 - 5);
  textSize(8);
  text("G", forceNameX + 7.5, height*.775);
  
  textSize(14);
  text("F  = ", forceNameX, height*.815 - 5);
  textSize(8);
  text("N", forceNameX + 7.5, height*.815);
  
  textSize(14);
  text("F  = ", forceNameX, height*.855 - 5);
  textSize(8);
  text("L", forceNameX + 7.5, height*.855);
  
  textSize(14);
  text("F  = ", forceNameX, height*.895 - 5);
  textSize(8);
  text("R", forceNameX + 7.5, height*.895);
  
  textSize(14);
  text("F  = ", forceNameX, height*.935 - 5);
  textSize(8);
  text("F", forceNameX + 7.5, height*.935);
  
  float forceMagnitudeX = width * .65;
  
  textSize(12);
  text(fG + " N", forceMagnitudeX, height*.775 - 5);
  text(fN + " N", forceMagnitudeX, height*.815 - 5);
  text(fL + " N", forceMagnitudeX, height*.855 - 5);
  text(fR + " N", forceMagnitudeX, height*.895 - 5);
  text(fF + " N", forceMagnitudeX, height*.935 - 5);
  
  //Physics Feedback - Block Accelerations
  
  float accelerationNameX = width*.8;
  
  textSize(14);
  text("a  = ", accelerationNameX, height*.775 - 5);
  textSize(8);
  text("x", accelerationNameX + 7.5, height*.775);
  
  textSize(14);
  text("a  = ", accelerationNameX, height*.815 - 5);
  textSize(8);
  text("y", accelerationNameX + 7.5, height*.815);
  
  textSize(14);
  text("a  = ", accelerationNameX, height*.855 - 5);
  textSize(8);
  text("sys", accelerationNameX + 7.5, height*.855);
  
  float accelerationValueX = width * .85;
  
  textSize(12);
  text(aX + " m/s^2", accelerationValueX, height*.775 - 5);
  text(aY + " m/s^2", accelerationValueX, height*.815 - 5);
  text(aSys + " m/s^2", accelerationValueX, height*.855 - 5);
  
  //Physics Feedback - Angles Between Vector and Horizontal
  
  textSize(14);
  text("Θ  = ", accelerationNameX, height*.895 - 5);
  textSize(8);
  text("L", accelerationNameX + 12.5, height*.895);
  
  textSize(14);
  text("Θ  = ", accelerationNameX, height*.935 - 5);
  textSize(8);
  text("R", accelerationNameX + 12.5, height*.935);
  
  textSize(12);
  if (leftForce) text(abs(degrees(left.angle)) + " deg", accelerationValueX, height*.895 - 5);
  if (rightForce) text(abs(degrees(right.angle)) + " deg", accelerationValueX, height*.935 - 5);
  
}
  
void mousePressed() {
  
  //Block mass changes from button clicks
    
  if (mousePressed && mouseX > buttonWidthPos1 - 20 && mouseX < buttonWidthPos1 + 20 && mouseY > buttonHeight - 20 && mouseY < buttonHeight + 20) blockMass++;
  if (mousePressed && mouseX > buttonWidthNeg1 - 20 && mouseX < buttonWidthNeg1 + 20 && mouseY > buttonHeight - 20 && mouseY < buttonHeight + 20) blockMass--;
  
  //Coefficient of friction changes from button clicks
  
  if (mousePressed && mouseX > buttonWidthPos2 - 20 && mouseX < buttonWidthPos2 + 20 && mouseY > buttonHeight - 20 && mouseY < buttonHeight + 20) coefFriction += 0.05;
  if (mousePressed && mouseX > buttonWidthNeg2 - 20 && mouseX < buttonWidthNeg2 + 20 && mouseY > buttonHeight - 20 && mouseY < buttonHeight + 20) coefFriction -= 0.05;
  
}

void mouseDragged() { //Allows user to view movement of force vector with dragging of mouse.
  
  if (mouseX < blockX - blockWidth/2 && moveLeft == true) {
    
    moveRight = false;
    leftForce = true;
    left = new VectorArrow(blockX - blockWidth/2, blockY, mouseX, mouseY, "L", -25, -10, false);
    
  }
  
   if (mouseX > blockX + blockWidth/2 && moveRight == true) {
    
    moveLeft = false;
    rightForce = true;
    right = new VectorArrow(blockX + blockWidth/2, blockY, mouseX, mouseY, "R", 25, -10, false);
    
  }
  
}

void mouseReleased() { //Sets force vectors upon release of mouse.
  
  if (moveLeft == true && mouseX < blockX - blockWidth/2) {
    tempXL = mouseX;
    tempYL = mouseY;
  }
  
  if (moveRight == true && mouseX > blockX + blockWidth/2) {
    tempXR = mouseX;
    tempYR = mouseY;
  }
  
}

void keyPressed() { //Allows for user keyboard input to enable and disable left and right force vector alterations.
  
  if (key == 'l') {
    moveLeft = !moveLeft;
  }
  
  if (key == 'r') {
    moveRight = !moveRight;
  }
  
}