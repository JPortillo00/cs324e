
Streak sp;
MorphingStar ms1;
MorphingStar ms2;
MorphingStar ms3;
MorphingStar ms4;


void setup(){
   size(600,600);
  background(0);
  sp = new Streak(300,300,600,600,.6,5);
  //sp = new Streak(300,300,600,600,.001,3);
  ms1 = new MorphingStar(5, 200, 200, 50, 30, 0.05, 0.05, 1);
  ms2 = new MorphingStar(6, 200, 400, 50, 30, -0.04, -0.04, 2);
  ms3 = new MorphingStar(7, 400, 200, 50, 30, 0.03, 0.03, 3);
  ms4 = new MorphingStar(8, 400, 400, 50, 30, -0.06, -0.06, 4);
  
}

void draw(){
  //clear();
  MyDraw();
  ms1.update();
  ms1.render();
  ms2.update();
  ms2.render();
  ms3.update();
  ms3.render();
  ms4.update();
  ms4.render();
  pushMatrix();
  translate(width/4,height/4);
  PImage img;
  img = loadImage("hypnotoad.png");
  img.resize(300,300);
  image(img,0,0);
  popMatrix();
  pushMatrix();   
  colorMode(RGB);
  fill(255,255,5);
  
 translate(180,180);

  Eye X = new Eye();  
  
  X.display();
  
 
 translate(100,0);
 Eye y = new Eye();
  y.display();
  popMatrix();
  
  

}

void MyDraw(){   
  sp.colour();
  sp.shift();
  sp.move();
  sp.display2();
  sp.display1();
}