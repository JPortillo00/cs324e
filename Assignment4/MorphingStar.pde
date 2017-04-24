
public class MorphingStar {
  float[] x;
  float[] y;
  float centerx;
  float centery;
  float radius;
  float radialChange;
  float rotationRate;
  float morphRate;
  float colorRate;
  int t;
  int outerPoints;
  Spark[] sparks;
  
  public MorphingStar(int n, float cx, float cy, float r, float dr, float rrate, float mrate, float crate) {
    sparks = new Spark[n];
    for (int i = 0; i < n; i++) {
      sparks[i] = new Spark(this, i, 0.025, dr, random(0.01));
    }
    x = new float[2*n];
    y = new float[2*n];
    for (int i = 0; i < 2*n; i++) {
      x[i] = cx + r*cos(PI*i/(float)n);
      y[i] = cy + r*sin(PI*i/(float)n);
    }
    t = 0;
    centerx = cx;
    centery = cy;
    radius = r;
    radialChange = dr;
    rotationRate = rrate;
    morphRate = mrate;
    colorRate = crate;
    outerPoints = n;
  }
  
  public void update() {
    t++;
    for (int i = 0; i < 2*outerPoints; i++) {
      if (i % 2 == 0) {
        x[i] = centerx + (radius + radialChange*sin(morphRate*t)) * cos(PI*i/outerPoints+rotationRate*t);
        y[i] = centery + (radius + radialChange*sin(morphRate*t)) * sin(PI*i/outerPoints+rotationRate*t);
      }
      else {
        x[i] = centerx + (radius - radialChange*sin(morphRate*t)) * cos(PI*i/outerPoints+rotationRate*t);
        y[i] = centery + (radius - radialChange*sin(morphRate*t)) * sin(PI*i/outerPoints+rotationRate*t);
      }
    }
    for (int i = 0; i < outerPoints; i++) {
      sparks[i].update();
    }
  }
  
  public void render() {
    beginShape();
    colorMode(HSB);
    fill(color((colorRate*t)%256, 255, 255));
    for (int i = 0; i < 2*outerPoints; i++) {
      vertex(x[i], y[i]);
    }
    endShape(CLOSE);
    for (int i = 0; i < outerPoints; i++) {
      sparks[i].render();
    }
  }
  
  public int getNumOuterPoints() {
    return outerPoints;
  }
  
  public float getRadius() {
    return radius;
  }
  
  public float getCenterX() {
    return centerx;
  }
  
  public float getCenterY() {
    return centery;
  }
  
  public int getTime() {
    return t;
  }
}

/*
MorphingStar star1;
MorphingStar star2;
MorphingStar star3;

void setup() {
  size(500, 500);
  star1 = new MorphingStar(5, 250, 250, 100, 50, 0.005, 0.05, 1);
  star2 = new MorphingStar(7, 400, 400, 40, 15, 0.01, 0.1, 2);
  star3 = new MorphingStar(6, 100, 100, 40, 25, 0.05, 0.05, 2.5);
}

void draw() {
  star1.update();
  star2.update();
  star3.update();
  //Clear screen
  colorMode(RGB);
  fill(color(0));
  rect(0, 0, 500, 500);
  star1.render();
  star2.render();
  star3.render();
}
*/