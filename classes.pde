class VectorArrow { //Allows for drawing of force vectors and their components.
  
  float x0, y0, x1, y1;
  
  PVector dMain, dX, dY;
  
  float angle;
  
  float buttonX, buttonY, buttonDiam;
  
  float transparency = 255; //Adjusts transparency of force vector if clicked.  (Allows user to see all forces more easily.)
  
  //float textOffsetX, textOffSetY;
  
  VectorArrow(float x0, float y0, float x1, float y1, String forceType, float textOffsetX, float textOffsetY, boolean showButton) {
    
      forceName(x1, y1, forceType, textOffsetX, textOffsetY);
      
      dMain = new PVector(x1 - x0, y1 - y0);
      dX = new PVector(x1 - x0, 0);
      dY = new PVector(0, y1 - y0);
      
      angle = angleCalc(x0, y0, x1, y1);
      
      //println(angle);
      
      drawVector(dMain, x0, y0, x1, y1, 4, 0, 6, true);
      
      if (angle != 0 && angle != PI/2 && angle != -PI/2) {
      
      drawVector(dX, x0, y0, x1, y0, 2, 0, 3, true);
      drawVector(dY, x1, y0, x1, y1, 2, 0, 3, true);
      
      }
    
  }
  
  void drawVector(PVector vector, float xVal0, float yVal0, float xVal1, float yVal1, int weight, int beginHeadSize, int endHeadSize, boolean filled) {
  
    vector.normalize();
    
    float coeff = 1.5;
    
    strokeCap(SQUARE);
    
    stroke(0, transparency);
    strokeWeight(weight);
    
    line(xVal0+vector.x*beginHeadSize*coeff/(filled?1.0f:1.75f), 
          yVal0+vector.y*beginHeadSize*coeff/(filled?1.0f:1.75f), 
          xVal1-vector.x*endHeadSize*coeff/(filled?1.0f:1.75f), 
          yVal1-vector.y*endHeadSize*coeff/(filled?1.0f:1.75f));
          
    float angle = atan2(vector.y, vector.x);
    
      if (filled) {
        // begin head
        pushMatrix();
        translate(xVal0, yVal0);
        rotate(angle+PI);
        triangle(-beginHeadSize*coeff, -beginHeadSize, 
                 -beginHeadSize*coeff, beginHeadSize, 
                 0, 0);
        popMatrix();
        // end head
        pushMatrix();
        translate(xVal1, yVal1);
        rotate(angle);
        triangle(-endHeadSize*coeff, -endHeadSize, 
                 -endHeadSize*coeff, endHeadSize, 
                 0, 0);
        popMatrix();
      } 
      
      else {
        // begin head
        pushMatrix();
        translate(xVal0, yVal0);
        rotate(angle+PI);
        strokeCap(ROUND);
        line(-beginHeadSize*coeff, -beginHeadSize, 0, 0);
        line(-beginHeadSize*coeff, beginHeadSize, 0, 0);
        popMatrix();
        // end head
        pushMatrix();
        translate(xVal1, yVal1);
        rotate(angle);
        strokeCap(ROUND);
        line(-endHeadSize*coeff, -endHeadSize, 0, 0);
        line(-endHeadSize*coeff, endHeadSize, 0, 0);
        popMatrix();
      }
    
  }
  
  float angleCalc(float xVal0, float yVal0, float xVal1, float yVal1) {
    
    float xComp = xVal0 - xVal1;
    float yComp = -(yVal0 - yVal1); //Because Processing uses higher y-values for points lower on the canvas, make this value negative.
    
    float angle = atan(yComp/xComp);
    
    return angle;
    
  }
  
  void forceName(float xVal, float yVal, String forceType, float textOffsetX, float textOffsetY) {
    
    float textX = xVal + textOffsetX;
    float textY = yVal + textOffsetY;
    
    textAlign(CENTER, CENTER);
    fill(0, transparency);
    
    textSize(18);
    text("F", textX, textY);
    
    textSize(12);
    text(forceType, textX + 10, textY + 5);
    
    fill(255);
    
  }
  
}