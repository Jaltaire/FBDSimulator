/* Free-Body Diagram Simulator by Jonathan Alter */

int d, m, y; //Instantiates date, month, year.
int h, min, s, ms; //Instantiates hour, minute, second, and millisecond.

float aG; //Instantiates constant for acceleration due to gravity.

float blockX, blockY, blockWidth, blockHeight;

int blockMass;
float coefFriction;

VectorArrow gravity;
VectorArrow normal;

VectorArrow left;
VectorArrow right;

VectorArrow friction;

int innerPanelWidth;
int innerPanelHeight;
int panelCornerRadius;

float buttonWidthPos1, buttonWidthPos2;
float buttonWidthNeg1, buttonWidthNeg2;

float buttonHeight;

int groundAlpha;

float tempXL, tempYL, tempXR, tempYR;
boolean leftForce, rightForce;
boolean moveLeft, moveRight;

float fG, fN, fL, fR, fF;
float aX, aY, aSys;

float leftForceMagnitudeX, leftForceMagnitudeY;
float rightForceMagnitudeX, rightForceMagnitudeY;

boolean normalForce, frictionForce;

float fNetX, fNetY;

void setup() {
  
  size(800, 500);
  
  blockX = width * .5;
  blockY = height * .4;
  blockWidth = 80;
  blockHeight = 30;
  
  blockMass = 10;
  
  coefFriction = 0.5;
    
  groundAlpha = 255;
  
  tempXL = blockX - blockWidth/2;
  tempYL = blockY;
  
  tempXR = blockX + blockWidth/2;
  tempYR = blockY;
  
  leftForce = false;
  rightForce = false;
  normalForce = true;
  frictionForce = false;
  
  moveLeft = true;
  moveRight = true;
  
  fL = 0;
  fR = 0;
  
  fNetX = 0;
  fNetY = 0;
  
  aG = 9.81;
  
}

void draw() {
  
  background(255);

  simulationMetaData();
  directions();
  ground();
  block();
  controls();
  
  physicsSetup();
    
}