
public class Spark {
  MorphingStar parent;
  float x;
  float y;
  int index;
  float rotationRate;
  float changeRadius;
  float changeRate;
  
  public Spark(MorphingStar p, int i, float rr, float cr, float cra) {
    parent = p;
    index = i;
    rotationRate = rr;
    changeRadius = cr;
    changeRate = cra;
  }
  
  public void update() {
    x = parent.getCenterX() + (parent.getRadius() + changeRadius*cos(changeRate*parent.getTime()))*cos(2*PI*index/parent.getNumOuterPoints() + rotationRate*parent.getTime());
    y = parent.getCenterY() + (parent.getRadius() + changeRadius*sin(changeRate*parent.getTime()))*sin(2*PI*index/parent.getNumOuterPoints() + rotationRate*parent.getTime());
  }
  
  public void render() {
    beginShape();
    colorMode(HSB);
    fill(color((256*index/parent.getNumOuterPoints())%256, 255, 255));
    for (int i = 0; i < parent.getNumOuterPoints(); i++) {
      vertex(x+random(20)*cos(random(2*PI)), y+random(20)*sin(random(2*PI)));
    }
    endShape();
  }
}