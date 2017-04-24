class Eye {
  PShape eye = createShape(ELLIPSE, 0, 0, 80,80);
  float ywig = random(-15,10);
  float xwig = random(-13,8);
  float xend1 = -30+xwig;
  float xend2 = 30+xwig;
  float yend = 5;
  float x2 = -10+xwig;
  float y2 = 0+ywig;
  float x3 = 10+xwig;
  float y3 = 0+ywig;
  float c1x = -30;
  float c1y = -1+ywig;
  float c2x = -10+xwig;
  float c2y = 5+ywig;
  float c3x = -10-xwig;
  float c3y = -2+ywig;
  float ywig2 = random(-15,10);
  float xwig2 = random(-15,10);
  float c4x = 10+xwig2;
  float c4y = -2+ywig2;
  float c5x = 10-xwig2;
  float c5y = 1+ywig2;
  float c6x = 30;
  float c6y = -1;
  
  void display(){
    colorMode(RGB);
    shape(eye);
    beginShape();
    strokeWeight(random(3,10));
    strokeJoin(ROUND);
    vertex(xend1,yend);
    bezierVertex(c1x,c1y,c2x,c2y,x2,y2);
    bezierVertex(c3x,c3y,c4x,c4y,x3,y3);
    bezierVertex(c5x,c5y,c6x,c6y,xend2,yend);
    endShape();
  }
};