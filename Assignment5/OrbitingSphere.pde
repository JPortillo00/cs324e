class OrbitingSphere{
  float x,y,z,a,b,c;
  float r,d,max_d;
  float angle;
  float direction = -1;
  
  
  OrbitingSphere(float radius,float init_x, float init_y,float init_z,float distance){
    r = radius;
    x = init_x;
    y = init_y;
    z = init_z;
    max_d = distance;
    d = distance;
    angle = 0;
  
  }
  
  void orbit(){
    angle += PI/50;
    if (d/2 >= max_d*2){
      direction = -1;
    } else if (d/2<= - max_d*2){
      direction = 1;    
    }
    d += direction*5;
  
  }
  void display(){
    strokeWeight(1);
    stroke(255);
    pushMatrix();    
      translate(x,y,z);
      scale(.5);
     
      noFill();
      noStroke();
      //stroke(255/2);
      
      pushMatrix();
        rotateZ(angle + PI/8);
        translate(x+d/2,0,0);
        fill(255);
        sphere(r/2);
      popMatrix();
      
      pushMatrix();
        rotateZ(angle + PI/4);
        translate(-x-d/2,0,0);
        sphere(r/2);
      popMatrix();
      
      pushMatrix();
        rotateX(angle + 3*PI/8);
        translate(0,y+d/2,0);
        fill(0,255,0);
        sphere(r/2);
      popMatrix();
      
      pushMatrix();
        rotateX(angle + PI/2);
        translate(0,-(y+d/2),0);
        sphere(r/2);
      popMatrix();
      
      pushMatrix();
        rotateZ(PI/4);
        
        pushMatrix(); 
          rotateX(angle + 5*PI/8);
          translate(0,-(y+d/2),0);
          fill(0,0,255);
          sphere(r/2);
        popMatrix();
        
        pushMatrix(); 
          rotateX(angle + 3*PI/4);
          translate(0,(y+d/2),0);
          sphere(r/2);
        popMatrix();
      popMatrix();
      
      pushMatrix();    
        rotateZ(PI/4);
        
        pushMatrix();
          rotateY(angle + 7*PI/8);
          translate(x+d/2,0,0);
          fill(255,0,0);
          sphere(r/2);
        popMatrix();
        
        pushMatrix();
          rotateY(angle + PI);
          translate(-x-d/2,0,0);
          sphere(r/2);
        popMatrix();
      popMatrix();
    popMatrix();
    
  }

}