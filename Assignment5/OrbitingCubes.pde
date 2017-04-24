class OrbitingCubes {
  float x, y, z, dx, dy, dz, s, ds, v;
  color c1, c2;
  int t;
  CustomCube cube1, cube2;
  
  public OrbitingCubes(float x, float y, float z, float dx, float dy, float dz, float s, float ds, float v, color c1, color c2) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.dx = dx;
    this.dy = dy;
    this.dz = dz;
    this.s = s;
    this.ds = ds;
    this.v = v;
    this.c1 = c1;
    this.c2 = c2;
    cube1 = new CustomCube(ds + x, y, z, 0, 0, 0, s, c1);
    cube2 = new CustomCube(-ds + x, y, z, 0, 0, 0, s, c2);
    t = 0;
  }
  
  void update() {
    t++;
    cube1.move(x + ds*cos(v*t), y, z - ds*sin(v*t), 0.05/(1+v*v)*t, 0.05/(1+v*v)*t, 0.05/(1+v*v)*t);
    cube2.move(x - ds*cos(v*t), y, z + ds*sin(v*t), -0.05/(1+v*v)*t, -0.05/(1+v*v)*t, -0.05/(1+v*v)*t);
  }
  
  void render() {
    cube1.render();
    cube2.render();
  }

}