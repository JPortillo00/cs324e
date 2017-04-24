class Orb{
  
  float spin,theta,x,y,z, size,direction;
  public Orb(float xpos,float ypos, float zpos, float r, int dir){
    x = xpos;
    y = ypos;
    z = zpos;
    spin = 0;
    theta = 0;
    size = r;
    direction = dir;
  }
  
  void update(){
    //rotation
    spin+=.05*direction;
    rotateY(spin);
    rotateX(spin*.05);
    colorMode(RGB);
    stroke(int((sin(theta)*255)),int((cos(theta)*255)),int((sin(theta)*255)));
    sphereDetail(int((cos(theta)*5)+10));
    theta += TWO_PI/1000;
    tint(255,127);
  }
  void render(){
    strokeWeight(3);
    pushMatrix();
    translate(x, y, z);
    update();
    noFill();
    sphere(size);
    popMatrix();
  
  }

}