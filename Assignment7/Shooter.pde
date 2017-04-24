class Shooter {
  boolean paused = false;
  Grid grid;
  int debounce = 0;
  float angle = 90;
  ArrayList<Bubble> fired;
  Bubble[] nextBubbles;
  boolean guide = false;
  
  public Shooter(Grid ref) {
    grid = ref;
    fired = new ArrayList<Bubble>();
    nextBubbles = new Bubble[3];
    float x = grid.offx - grid.scale*0.5 + grid.scale*(grid.sy+0.5)/2.0;
    float y = grid.offy + grid.scale*0.5 + grid.scale*(grid.sx-1)*sqrt(3)/2.0 + grid.scale;
    float dx = grid.scale*2;
    nextBubbles[0] = new Bubble(x, y, randomColor());
    nextBubbles[1] = new Bubble(x+dx, y, randomColor());
    nextBubbles[2] = new Bubble(x+2*dx, y, randomColor());
  }
  
  public void reset() {
    angle = 90;
    guide = false;
    paused = false;
    debounce = 10;
    fired = new ArrayList<Bubble>();
    nextBubbles = new Bubble[3];
    float x = grid.offx - grid.scale*0.5 + grid.scale*(grid.sy+0.5)/2.0;
    float y = grid.offy + grid.scale*0.5 + grid.scale*(grid.sx-1)*sqrt(3)/2.0 + grid.scale;
    float dx = grid.scale*2;
    nextBubbles[0] = new Bubble(x, y, randomColor());
    nextBubbles[1] = new Bubble(x+dx, y, randomColor());
    nextBubbles[2] = new Bubble(x+2*dx, y, randomColor());
  }
  
  public void update() {
    debounce--;
    if (!paused) {
      for (Bubble bubble : fired) {
        bubble.update();
      }
      //Collision
      for (int i = fired.size()-1; i >= 0; i--) {
        boolean collision = grid.collide(fired.get(i).getX(), fired.get(i).getY(), fired.get(i).getColor());
        if (collision) {
            fired.remove(i);
        }
      }
    }
  }
  
  public void render() {
    for (Bubble bubble : nextBubbles) {
      bubble.render(grid.scale);
    }
    
    int x = (int)(grid.offx - grid.scale*0.5 + grid.scale*(grid.sy+0.5)/2.0);
    int y = (int)(grid.offy + grid.scale*0.5 + grid.scale*(grid.sx-1)*sqrt(3)/2.0);
    
    stroke(255, 255, 255);
    noFill();
    rect(x - grid.scale*0.75, y + grid.scale*0.25, grid.scale*5.5, grid.scale*1.5);
    
    float xfactor = cos(angle*PI/180);
    float yfactor = sin(angle*PI/180);
    
    noStroke();
    
    fill(128);
    ellipse(x, y, 30, 30);
    fill(255);
    ellipse(x+xfactor*20, y-yfactor*20, 10, 10);
    
    //Draw fired bubbles
    for (Bubble bubble : fired) {
      bubble.render(grid.scale);
    }
    
    if (guide) {
      float gx = x +xfactor*30;
      float gy = y-yfactor*30;
      fill(64, 64, 64, 128);
      int dir = 1;
      while (gy > grid.offy) {
        ellipse(gx, gy, 5, 5);
        gx += dir*xfactor*10;
        gy -= yfactor*10;
        if (gx >= 620) {
          gx = 620;
          //x -= xfactor*20;
          dir *= -1;
        }
        if (gx <= 50) {
          gx = 50;
          //x += xfactor*20;
          dir *= -1;
        }
      }
    }
  }
  
  //Call this upon pressing left arrow
  public void increaseAngle() {
    if (!paused) {
      angle += 1;
      if (angle > 165) 
        angle = 165;
    }
  }
  
  //Call this upon pressing right arrow
  public void decreaseAngle() {
    if (!paused) {
      angle -= 1;
      if (angle < 15)
        angle = 15;
    }
  }
  
  public void toggleGuide() {
    if (!paused && debounce <= 0) {
      debounce = 20;
      guide = !guide;
    }
  }
  
  public void togglePause() {
    if (debounce <= 0) {
      debounce = 20;
      paused = !paused;
    }
  }
  
  public void shoot() {
    if (!paused && debounce <= 0) {
      debounce = 20; //Prevent from shooting again in a small interval of time
      //Shoot a bubble with color nextColors[0] at angle angle
      int x = (int)(grid.offx - grid.scale*0.5 + grid.scale*(grid.sy+0.5)/2.0);
      int y = (int)(grid.offy + grid.scale*0.5 + grid.scale*(grid.sx-1)*sqrt(3)/2.0);
    
      float xvector = 10*cos(angle*PI/180);
      float yvector = -10*sin(angle*PI/180);
      
      Bubble bubble = new Bubble(x+xvector, y+yvector, xvector, yvector, nextBubbles[0].getColor());
      
      fired.add(bubble);
      
      nextBubbles[0] = nextBubbles[1];
      nextBubbles[0].setX(nextBubbles[0].getX()-2*grid.scale);
      nextBubbles[1] = nextBubbles[2];
      nextBubbles[1].setX(nextBubbles[1].getX()-2*grid.scale);
      float nx = grid.offx - grid.scale*0.5 + grid.scale*(grid.sy+0.5)/2.0 + grid.scale*4;
      float ny = grid.offy + grid.scale*0.5 + grid.scale*(grid.sx-1)*sqrt(3)/2.0 + grid.scale;
      nextBubbles[2] = new Bubble(nx, ny, randomColor());
    }
  }
  
  public color randomColor() {
    color[] colors = {color(255,0,0), color(255,255,0), color(0,255,0), color(0,255,255), color(0,0,255), color(255,0,255)};
    int r = (int)random(6);
    return colors[r];
  }
  
}