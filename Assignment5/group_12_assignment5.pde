OrbitingSphere test;
OrbitingCubes oc1, oc2, oc3;
Orb ball,ball2;
//Orb orb;

void setup(){
  size(600,600,P3D);
  background(0);
  test = new OrbitingSphere(100,300,300,-300,300);
  oc1 = new OrbitingCubes(300, 250, 300, 0, 0, 0, 20, 60, 0.01*2, color(255, 0, 0), color(0, 255, 255));
  oc2 = new OrbitingCubes(300, 300, 300, 0, 0, 0, 20, 60, 0.01*3, color(0, 255, 0), color(255, 0, 255));
  oc3 = new OrbitingCubes(300, 350, 300, 0, 0, 0, 20, 60, 0.01*5, color(0, 0, 255), color(255, 255, 0));
  ball = new Orb(300, 300, 300,50,1);
  ball2 = new Orb(300,300,300,30,-1);
}

void draw(){
  background(0);
  test.display();
  test.orbit();
  oc1.update();
  oc1.render();
  oc2.update();
  oc2.render();
  oc3.update();
  oc3.render();
  ball.render();
  ball2.render();
}