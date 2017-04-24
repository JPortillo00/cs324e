class Bubble {
  color col;
  
  float x, y;
  float vx, vy;
  boolean toPop = false; //Play the pop animation and then set toRemove true if this is true
  boolean toFall = false; //Play the fall animation and then set toRemove true if this is true
  boolean toRemove = false; //Remove if this is true
  int popFrame = 0;
  int fallFrame = 0;
  int conn = 1; //temporary?
  
  public Bubble(float x, float y, color c) {
    this.x = x;
    this.y = y;
    col = c;
    vx = vy = 0;
  }
  
  public Bubble(float x, float y, float vx, float vy, color c) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    col = c;
  }
  
  public void update() {
    x += vx;
    y += vy;
    //Bounce
    int xmin = 50;
    int xmax = 20 + 600; //hardcoded...
    if (x < xmin) {
      x = xmin;
      vx = abs(vx);
    }
    if (x > xmax) {
      x = xmax;
      vx = -abs(vx);
    }
    //State updates
    if (willPop()) {
      popFrame++;
    }
    else if (willFall()) {
      fallFrame++;
    }
    //Remove at the end of animations
    if (popFrame > 10 || fallFrame > 10) {
      toRemove = true;
    }
  }
  
  public void render(int size) {
    noStroke();
    fill(col);
    if (!willFall() && !willPop()) {
      ellipse((int)x, (int)y, size, size);
      fill(red(col)*0.875+31, green(col)*0.875+31, blue(col)*0.875+31);
      ellipse((int)(x-size*0.03), (int)(y-size*0.03), size*0.75, size*0.75);
      fill(red(col)*0.75+63, green(col)*0.75+63, blue(col)*0.75+63);
      ellipse((int)(x-size*0.06), (int)(y-size*0.06), size*0.5, size*0.5);
      fill(color(255, 255, 255));
      ellipse((int)(x-size*0.25), (int)(y-size*0.25), size*0.1, size*0.1);
    }
    if (willFall()) {
      //Render something based on fallFrame
      fill(red(col), green(col), blue(col), 255 - 25*fallFrame);
      ellipse((int)x, (int)(y+fallFrame*5), size, size);
      fill(red(col)*0.875+31, green(col)*0.875+31, blue(col)*0.875+31, 255 - 25*fallFrame);
      ellipse((int)(x-size*0.03), (int)(y+fallFrame*5-size*0.03), size*0.75, size*0.75);
      fill(red(col)*0.75+63, green(col)*0.75+63, blue(col)*0.75+63, 255 - 25*fallFrame);
      ellipse((int)(x-size*0.06), (int)(y+fallFrame*5-size*0.06), size*0.5, size*0.5);
      fill(color(255, 255, 255, 255 - 25*fallFrame));
      ellipse((int)(x-size*0.25), (int)(y+fallFrame*5-size*0.25), size*0.1, size*0.1);
    }
    else if (willPop()) {
      //Render something based on popFrame
      fill(red(col), green(col), blue(col), 255 - 25*popFrame);
      ellipse((int)x, (int)y, size+0.1*size*popFrame, size+0.1*size*popFrame);
      fill(red(col)*0.875+31, green(col)*0.875+31, blue(col)*0.875+31, 255 - 25*popFrame);
      ellipse((int)(x-(size+0.1*size*popFrame)*0.03), (int)(y-(size+0.1*size*popFrame)*0.03), (size+0.1*size*popFrame)*0.75, (size+0.1*size*popFrame)*0.75);
      fill(red(col)*0.75+63, green(col)*0.75+63, blue(col)*0.75+63, 255 - 25*popFrame);
      ellipse((int)(x-(size+0.1*size*popFrame)*0.06), (int)(y-(size+0.1*size*popFrame)*0.06), (size+0.1*size*popFrame)*0.5, (size+0.1*size*popFrame)*0.5);
      fill(color(255, 255, 255, 255 - 25*popFrame));
      ellipse((int)(x-(size+0.1*size*popFrame)*0.25), (int)(y-(size+0.1*size*popFrame)*0.25), (size+0.1*size*popFrame)*0.1, (size+0.1*size*popFrame)*0.1);
    }
    //for debugging
    /*
    fill(0, 0, 0);
    for (int i = 0; i < conn; i++) {
      ellipse((int)(x+0.25*size*cos(2*PI*i/conn)), (int)(y+0.25*size*sin(2*PI*i/conn)), (int)(size*0.05), (int)(size*0.05));
    }
    */
  }
  
  public void setX(float nx) {
    x = nx;
  }
  
  public void setY(float ny) {
    y = ny;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public color getColor() {
    return col;
  }
  
  public void setToFall() {
    toFall = true;
  }
  
  public boolean willFall() {
    return toFall;
  }
  
  public void setToPop() {
    toPop = true;
  }
  
  public boolean willPop() {
    return toPop;
  }
  
  public boolean shouldBeRemoved() {
    return toRemove;
  }
}