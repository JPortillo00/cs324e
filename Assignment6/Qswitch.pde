class Qswitch{
  float h,w;
  float sq1x,sq1y,sq2x,sq2y;
  int sq1 = 0;
  int sq2 = 0;
  boolean oversq1 = false;
  boolean oversq2 = false;
  int mX,mY;

  public Qswitch(float init_height, float init_width , int mx, int my){
    h = init_height;
    w = init_width;
    sq1y = h*0.0625;
    sq2y = h*0.0625;
    sq1x = w/2 - 0.125*w;
    sq2x = w/2 + 0.125*w;
    mX = mx;
    mY = my;
    
      
  }
  
  boolean overRect(float x, float y, float wdth, float hght)  {
  if (x-wdth/2 <= mX && mX <= x+wdth/2 && 
      y-hght/2 <= mY && mY <= y+hght/2) {
    return true;
  } else {
    return false;
  }
}

void update(int a, int b) {
  mX = a;
  mY = b;
  if ( overRect(sq1x, sq1y, 75, 75)) {
    oversq1 = true;
    oversq2 = false;
  } else if ( overRect(sq2x, sq2y, 75, 75)) {
    oversq2 = true;
    oversq1 = false;
  } else {
    oversq1 = oversq2 = false;
  }
}

  void updateColor(){
    if(oversq1){
      if (sq1==0){
        sq1 = 255;
      }else{
        sq1 = 0;
      }
    }
    if(oversq2){
      if (sq2==0){
        sq2 = 255;
      }else{
        sq2 = 0;
      }    
    }
  }
  

 
  void display(){
    rectMode(CENTER);
    strokeWeight(5);
    stroke(#FF0000);
    update(mouseX,mouseY);   
    fill(color(sq1));
    rect(sq1x,sq1y,75,75);
    fill(color(sq2));
    rect(sq2x,sq2y,75,75);
    rectMode(CORNER);
    strokeWeight(1);
    stroke(0);    
  } 

 }