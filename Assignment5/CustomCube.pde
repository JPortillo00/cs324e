class CustomCube {
  float x, y, z;
  float rx, ry, rz;
  float s;
  color c;
  public CustomCube(float x, float y, float z, float rx, float ry, float rz, float s, color c) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.rx = rx;
    this.ry = ry;
    this.rz = rz;
    this.s = s;
    this.c = c;
  }
  
  void move(float x2, float y2, float z2, float rx2, float ry2, float rz2) {
    x = x2;
    y = y2;
    z = z2;
    rx = rx2;
    ry = ry2;
    rz = rz2;
  }
  
  void render() {
    fill(c);
    stroke(1);
    pushMatrix();
      translate(x, y, z);
      rotateZ(rz);
      rotateY(ry);
      rotateX(rx);
      beginShape();
        vertex(-s/2, -s/2, -s/2);
        vertex(-s/2, s/2, -s/2);
        vertex(s/2, s/2, -s/2);
        vertex(s/2, -s/2, -s/2);
      endShape();
      beginShape();
        vertex(-s/2, -s/2, s/2);
        vertex(-s/2, s/2, s/2);
        vertex(s/2, s/2, s/2);
        vertex(s/2, -s/2, s/2);
      endShape();
      beginShape();
        vertex(-s/2, -s/2, -s/2);
        vertex(-s/2, -s/2, s/2);
        vertex(s/2, -s/2, s/2);
        vertex(s/2, -s/2, -s/2);
      endShape();
      beginShape();
        vertex(-s/2, s/2, -s/2);
        vertex(-s/2, s/2, s/2);
        vertex(s/2, s/2, s/2);
        vertex(s/2, s/2, -s/2);
      endShape();
      beginShape();
        vertex(-s/2, -s/2, -s/2);
        vertex(-s/2, -s/2, s/2);
        vertex(-s/2, s/2, s/2);
        vertex(-s/2, s/2, -s/2);
      endShape();
      beginShape();
        vertex(s/2, -s/2, -s/2);
        vertex(s/2, -s/2, s/2);
        vertex(s/2, s/2, s/2);
        vertex(s/2, s/2, -s/2);
      endShape();
    popMatrix();
  }
}