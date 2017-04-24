class Grid {
  PFont font;
  int score = 0; //TODO: Update score when bubbles are popped or made to fall, based on the number removed in one shot.
  boolean win = false;
  boolean lose = false;
  int offx = 50; //Just some constants for the edge sizes
  int offy = 50;
  int sx;
  int sy;
  int scale;
  Bubble[][] data;
  
  public Grid(int sx, int sy, int scale) {
    this.sx = sx;
    this.sy = sy;
    this.scale = scale;
    data = new Bubble[sx][sy];
    font = createFont("Arial", 16, true);
  }
  
  public void reset() {
    win = false;
    lose = false;
    score = 0;
    data = new Bubble[sx][sy];
  }
  
  //Makes sure the bubbles are in the right place.
  public void update() {
    //Make sure the bubbles are in the correct position. Debatable whether this is necessary but it doesn't hurt.
    for (int i = 0; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        if (data[i][j] != null) {
          float[] pos = getPosition(i, j);
          data[i][j].setX(pos[0]);
          data[i][j].setY(pos[1]);
          data[i][j].update();
        }
      }
    }
    //Get connected bubbles and remove some if need be
    for (int i = 0; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        if (data[i][j] != null) {
          ArrayList<Bubble> connected = getConnectedBubbles(i, j);
          data[i][j].conn = connected.size();
          if (data[i][j].shouldBeRemoved()) {
            score += data[i][j].conn;
            removeBubble(i, j);
          }
        }
      }
    }
    //Make disconnected bubbles fall
    int fallCount = 0;
    for (int i = 1; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        if (data[i][j] != null) {
          if (!data[i][j].willFall() && !isConnectedToBase(i, j)) {
            data[i][j].setToFall();
            fallCount++;
          }
        }
      }
    }
    score += fallCount*fallCount; //bonus? :P
    println(score);
    //Count the number of bubbles remaining
    int count = 0;
    for (int i = 0; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        if (data[i][j] != null) {
          count++;
        }
        if (i == sx-1 && data[i][j] != null) {
          lose = true; //reached the bottom of the screen
          println("You lose!"); //This should be visual
          break;
        }
      }
      if (lose)
        break;
    }
    if (count == 0 && !win) {
      win = true; //Removed all the bubbles
      println("You won!"); //This should be visual
    }
  }
  
  //Assuming that x and y are within bounds...
  public float[] getPosition(int x, int y) {
    float[] res = new float[2];
    if (x % 2 == 0) {
      res[0] = offx+y*scale;
    }
    else {
      res[0] = offx+scale/2.0+y*scale;
    }
    res[1] = offy+x*scale*sqrt(3)/2.0;
    return res;
  }
  
  public void addBubble(int x, int y, color c) {
    if (x < 0 || x >= sx || y < 0 || y >= sy)
      return;
    float[] pos = getPosition(x, y);
    data[x][y] = new Bubble(pos[0], pos[1], c);
  }
  
  public boolean removeBubble(int x, int y) {
    if (x < 0 || x >= sx || y < 0 || y >= sy)
      return false;
    if (data[x][y] == null)
      return false;
    data[x][y] = null;
    return true;
  }
  
  public void render() {
    for (int i = 0; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        if (data[i][j] != null) {
          data[i][j].render(scale);
        }
      }
    }
    noFill();
    stroke(255, 255, 255);
    rect((int)(offx-scale*0.5), (int)(offy-scale*0.5), (int)(scale*(sy+0.5)), (int)(scale*(sx-1)*sqrt(3)/2.0+scale));
    textFont(font, 36);
    fill(255);
    text("Score: "+score, offx-20, offy+scale*sx-scale);
    if (win) {
      textFont(font, 84);
      fill(0, 0, 0, 180);
      rect(offx+scale, offy+scale*3, scale*8, scale*3);
      fill(255, 255, 255);
      text("You win!", offx + scale*2, offy+scale*5);
    }
    if (lose) {
      textFont(font, 84);
      fill(0, 0, 0, 180);
      rect(offx+scale, offy+scale*3, scale*8, scale*3);
      fill(255, 255, 255);
      text("You lose!", offx + scale*2, offy+scale*5);
    }
  }
  
  public int[] getClosestIndices(float x, float y) {
    int[] res = new int[8];
    //Super lazy way, but who cares about efficiency on a grid this small?
    int[] imins = new int[4];
    int[] jmins = new int[4];
    for (int k = 0; k < 4; k++) {
      imins[k] = 0;
      jmins[k] = k;
    }
    float[] mins = new float[4];
    for (int k = 0; k < 4; k++) {
      mins[k] = pow(10, 5+k);
    }
    for (int i = 0; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        float[] pos = getPosition(i, j);
        float dist2 = pow(x - pos[0], 2) + pow(y - pos[1], 2); //squared distance is fine here
        
        for (int k = 0; k < 4; k++) {
          if (dist2 < mins[k]) {
            boolean valid = true;
            for (int l = 0; l < k; l++) {
              if (imins[l] == i && jmins[l] == j) {
                valid = false;
                break;
              }
            }
            if (valid) {
              mins[k] = dist2;
              imins[k] = i;
              jmins[k] = j;
            }
          }
        }
      }
    }
    for (int k = 0; k < 4; k++) {
      res[2*k] = imins[k];
      res[2*k+1] = jmins[k];
    }
    return res;
  }
  
  public boolean collide(float x, float y, color c) {
    int[] indices = getClosestIndices(x, y);
    if (data[indices[0]][indices[1]] != null && data[indices[2]][indices[3]] == null) {
      //println("Collision case 1");
      addBubble(indices[2], indices[3], c);
      ArrayList<Bubble> connected = getConnectedBubbles(indices[2], indices[3]);
      if (connected.size() >= 3) {
        for (Bubble bubble : connected) {
          bubble.setToPop();
          pop.play();
        }
      }
      return true; //Remove the projectile
    }
    //Rare collision case
    else if (data[indices[0]][indices[1]] != null && data[indices[2]][indices[3]] != null && data[indices[4]][indices[5]] == null) {
      //println("Collision case 2");
      addBubble(indices[4], indices[5], c);
      ArrayList<Bubble> connected = getConnectedBubbles(indices[4], indices[5]);
      if (connected.size() >= 3) {
        for (Bubble bubble : connected) {
          bubble.setToPop();
        }
      }
      return true; //Remove the projectile
    }
    /*
    //Rarer collision case
    else if (data[indices[0]][indices[1]] != null && data[indices[2]][indices[3]] != null && data[indices[4]][indices[5]] != null && data[indices[6]][indices[7]] == null) {
      //println("Collision case 3");
      addBubble(indices[6], indices[7], c);
      ArrayList<Bubble> connected = getConnectedBubbles(indices[6], indices[7]);
      if (connected.size() >= 3) {
        for (Bubble bubble : connected) {
          bubble.setToPop();
        }
      }
      return true; //Remove the projectile
    }
    */
    //Collision with top of grid
    else if (y <= offy && data[indices[0]][indices[1]] == null) {
      //println("Collision with top");
      addBubble(indices[0], indices[1], c);
      ArrayList<Bubble> connected = getConnectedBubbles(indices[0], indices[1]);
      if (connected.size() >= 3) {
        for (Bubble bubble : connected) {
          bubble.setToPop();
        }
      }
      return true; //Remove the projectile
    }
    //Collision with top of grid, in special cases?
    return false; //Do nothing
  }
  
  public boolean isConnectedToBase(int x, int y) {
    if (x < 0 || x >= sx || y < 0 || y >= sy)
      return false;
    if (data[x][y] == null)
      return false;
    //if (x == 0)
      //return true;
    boolean[][] reached = new boolean[sx][sy];
    for (int i = 0; i < sx; i++) {
      for (int j = 0; j < sy; j++) {
        reached[i][j] = false;
      }
    }
    reached[x][y] = true;
    //Traverse the six paths
    boolean p1, p2, p3, p4, p5, p6;
    p1 = p2 = p3 = p4 = p5 = p6 = false;
    if (y+1 < sy && data[x][y+1] != null) {
      p1 = isConnectedToBase(x, y+1, reached);
    }
    if (x % 2 == 0) {
      if (x-1 >= 0 && data[x-1][y] != null) {
        p2 = isConnectedToBase(x-1, y, reached);
      }
      if (x-1 >= 0 && y-1 >= 0 && data[x-1][y-1] != null) {
        p3 = isConnectedToBase(x-1, y-1, reached);
      }
    }
    else {
      if (x-1 >= 0 && y+1 < sy && data[x-1][y+1] != null) {
        p2 = isConnectedToBase(x-1, y+1, reached);
      }
      if (x-1 >= 0 && data[x-1][y] != null) {
        p3 = isConnectedToBase(x-1, y, reached);
      }
    }
    if (y-1 >= 0 && data[x][y-1] != null) {
      p4 = isConnectedToBase(x, y-1, reached);
    }
    if (x % 2 == 0) {
      
      if (x+1 < sx && y-1 >= 0 && data[x+1][y-1] != null) {
        p5 = isConnectedToBase(x+1, y-1, reached);
      }
      if (x+1 < sx && data[x+1][y] != null) {
        p6 = isConnectedToBase(x+1, y, reached);
      }
    }
    else {
      if (x+1 < sx && data[x+1][y] != null) {
        p5 = isConnectedToBase(x+1, y, reached);
      }
      if (x+1 < sx && y+1 < sy && data[x+1][y+1] != null) {
        p6 = isConnectedToBase(x+1, y+1, reached);
      }
    }
    return (p1 || p2 || p3 || p4 || p5 || p6);
  }
  
  public boolean isConnectedToBase(int x, int y, boolean[][] reached) {
    reached[x][y] = true;
    if (x == 0)
      return true;
    //Traverse the six paths
    boolean p1, p2, p3, p4, p5, p6;
    p1 = p2 = p3 = p4 = p5 = p6 = false;
    if (y+1 < sy && !reached[x][y+1] && data[x][y+1] != null) {
      p1 = isConnectedToBase(x, y+1, reached);
    }
    if (x % 2 == 0) {
      if (x-1 >= 0 && !reached[x-1][y] && data[x-1][y] != null) {
        p2 = isConnectedToBase(x-1, y, reached);
      }
      if (x-1 >= 0 && y-1 >= 0 && !reached[x-1][y-1] && data[x-1][y-1] != null) {
        p3 = isConnectedToBase(x-1, y-1, reached);
      }
    }
    else {
      if (x-1 >= 0 && y+1 < sy && !reached[x-1][y+1] && data[x-1][y+1] != null) {
        p2 = isConnectedToBase(x-1, y+1, reached);
      }
      if (x-1 >= 0 && !reached[x-1][y] && data[x-1][y] != null) {
        p3 = isConnectedToBase(x-1, y, reached);
      }
    }
    if (y-1 >= 0 && !reached[x][y-1] && data[x][y-1] != null) {
      p4 = isConnectedToBase(x, y-1, reached);
    }
    if (x % 2 == 0) {
      if (x+1 < sx && y-1 >= 0 && !reached[x+1][y-1] && data[x+1][y-1] != null) {
        p5 = isConnectedToBase(x+1, y-1, reached);
      }
      if (x+1 < sx && !reached[x+1][y] && data[x+1][y] != null) {
        p6 = isConnectedToBase(x+1, y, reached);
      }
    }
    else {
      if (x+1 < sx && !reached[x+1][y] && data[x+1][y] != null) {
        p5 = isConnectedToBase(x+1, y, reached);
      }
      if (x+1 < sx && y+1 < sy && !reached[x+1][y+1] && data[x+1][y+1] != null) {
        p6 = isConnectedToBase(x+1, y+1, reached);
      }
    }
    return (p1 || p2 || p3 || p4 || p5 || p6);
  }
  
  public ArrayList<Bubble> getConnectedBubbles(int x, int y) {
    ArrayList<Bubble> res = new ArrayList<Bubble>();
    if (x < 0 || x >= sx || y < 0 || y >= sy)
      return res; //empty
    if (data[x][y] == null)
      return res; //empty
    res.add(data[x][y]);
    color col = data[x][y].getColor();
    //Check the six paths...
    if (y+1 < sy && data[x][y+1] != null) {
      getConnectedBubbles(x, y+1, col, res);
    }
    if (x % 2 == 0) {
      if (x-1 >= 0 && data[x-1][y] != null) {
        getConnectedBubbles(x-1, y, col, res);
      }
      if (x-1 >= 0 && y-1 >= 0 && data[x-1][y-1] != null) {
        getConnectedBubbles(x-1, y-1, col, res);
      }
    }
    else {
      if (x-1 >= 0 && y+1 < sy && data[x-1][y+1] != null) {
        getConnectedBubbles(x-1, y+1, col, res);
      }
      if (x-1 >= 0 && data[x-1][y] != null) {
        getConnectedBubbles(x-1, y, col, res);
      }
    }
    if (y-1 >= 0 && data[x][y-1] != null) {
      getConnectedBubbles(x, y-1, col, res);
    }
    if (x % 2 == 0) {
      if (x+1 < sx && y-1 >= 0 && data[x+1][y-1] != null) {
        getConnectedBubbles(x+1, y-1, col, res);
      }
      if (x+1 < sx && data[x+1][y] != null) {
        getConnectedBubbles(x+1, y, col, res);
      }
    }
    else {
      if (x+1 < sx && data[x+1][y] != null) {
        getConnectedBubbles(x+1, y, col, res);
      }
      if (x+1 < sx && y+1 < sy && data[x+1][y+1] != null) {
        getConnectedBubbles(x+1, y+1, col, res);
      }
    }
    return res;
  }
  
  public void getConnectedBubbles(int x, int y, color c, ArrayList<Bubble> res) {
    color col = data[x][y].getColor();
    if (c != col)
      return;
      
    //Extra check
    boolean valid = true;
    for (Bubble b : res) {
      float[] p = getPosition(x, y);
      if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
        valid = false;
        break;
      }
    }
    if (!valid)
      return;
    
    res.add(data[x][y]);
    
    //Check the six paths...
    boolean p1valid = true;
    for (Bubble b : res) {
      float[] p = getPosition(x, y+1);
      if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
        p1valid = false;
        break;
      }
    }
    if (p1valid && y+1 < sy && data[x][y+1] != null) {
      getConnectedBubbles(x, y+1, col, res);
    }
    if (x % 2 == 0) {
      boolean p2valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x-1, y);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p2valid = false;
          break;
        }
      }
      if (p2valid && x-1 >= 0 && data[x-1][y] != null) {
        getConnectedBubbles(x-1, y, col, res);
      }
      boolean p3valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x-1, y-1);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p3valid = false;
          break;
        }
      }
      if (p3valid && x-1 >= 0 && y-1 >= 0 && data[x-1][y-1] != null) {
        getConnectedBubbles(x-1, y-1, col, res);
      }
    }
    else {
      boolean p2valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x-1, y+1);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p2valid = false;
          break;
        }
      }
      if (p2valid && x-1 >= 0 && y+1 < sy && data[x-1][y+1] != null) {
        getConnectedBubbles(x-1, y+1, col, res);
      }
      boolean p3valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x-1, y);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p3valid = false;
          break;
        }
      }
      if (p3valid && x-1 >= 0 && data[x-1][y] != null) {
        getConnectedBubbles(x-1, y, col, res);
      }
    }
    boolean p4valid = true;
    for (Bubble b : res) {
      float[] p = getPosition(x, y-1);
      if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
        p4valid = false;
        break;
      }
    }
    if (p4valid && y-1 >= 0 && data[x][y-1] != null) {
      getConnectedBubbles(x, y-1, col, res);
    }
    if (x % 2 == 0) {
      boolean p5valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x+1, y-1);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p5valid = false;
          break;
        }
      }
      if (p5valid && x+1 < sx && y-1 >= 0 && data[x+1][y-1] != null) {
        getConnectedBubbles(x+1, y-1, col, res);
      }
      boolean p6valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x+1, y);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p6valid = false;
          break;
        }
      }
      if (p6valid && x+1 < sx && data[x+1][y] != null) {
        getConnectedBubbles(x+1, y, col, res);
      }
    }
    else {
      boolean p5valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x+1, y);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p5valid = false;
          break;
        }
      }
      if (p5valid && x+1 < sx && data[x+1][y] != null) {
        getConnectedBubbles(x+1, y, col, res);
      }
      boolean p6valid = true;
      for (Bubble b : res) {
        float[] p = getPosition(x+1, y+1);
        if (abs(b.getX()-p[0]) < scale/4.0 && abs(b.getY()-p[1]) < scale/4.0) {
          p6valid = false;
          break;
        }
      }
      if (p6valid && x+1 < sx && y+1 < sy && data[x+1][y+1] != null) {
        getConnectedBubbles(x+1, y+1, col, res);
      }
    }
  }
}
//If the row index is even:
//    o o   - [i-1][j-1], [i-1][j] 
//   o o o  - [i][j-1], [i][j], [i][j+1]
//    o o   - [i+1][j-1], [i+1][j]
//If the row index is odd:
//    o o   - [i-1][j], [i-1][j+1] 
//   o o o  - [i][j-1], [i][j], [i][j+1]
//    o o   - [i+1][j], [i+1][j+1]