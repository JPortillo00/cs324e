class Streak {
  
  float init_x,init_y,h,w;
  float min_h,min_w,max_h,max_w;
  float limit_h,limit_w;
  float growth;
  float scale;
  float area;
  float min_size;
  color c;
  int direction = 1;
      
  Streak (float xpos, float ypos, float init_height, float init_width,float sc, float ds){
    init_x = xpos;
    init_y = ypos;
    h = init_height;
    w = init_width;
    min_h = sc*init_height;
    min_w = sc*init_width;    
    scale = sc;
    growth = ds;
    area = init_height * init_width;
    min_size = sqrt(area/30);
    limit_h = init_height - min_size;
    limit_w = init_width - min_size;
    max_h = init_height;
    max_w = init_width;
  }
  float small_s = min_size/2;
  float a = small_s;
  float b = small_s;
  int count = 0;
    
  void move(){
    switch(direction){
      case 1:
        b += growth;
        break;
      case 2:
        a += growth;
        break;
      case 3:
        b -= growth;
        break;
      case 4:
        a -= growth;
        break;    
    }
    if (direction == 1 && b > (max_h - small_s)){
      b = (max_h - small_s);
      direction = 2;
    } else if (direction == 2 && a > (max_w - small_s)){
      a = (max_w - small_s);  
      direction = 3;
    }else if (direction == 3 && b < small_s){
      b = small_s;
      direction = 4;   
    }else if (direction == 4 && a < small_s){
      a = small_s;
      direction = 1;
    }
        
  }
  
  void colour(){
    float r = random(100,255);
    float g = random(100,255);
    float b = random(100,255);
    c = color(r,g,b);
      
  }
  
  void shift(){
    h += (growth * -1);
    w += (growth * -1);
    if((h < min_h) && (w < min_w)){
      h = limit_h;
      w = limit_w;          
    }    
    
  }
  
  void display1(){
    fill(c);
    noStroke();    
    rectMode(CENTER);
    rect(a,b,min_size,min_size);
    noFill();
    stroke(0);
    
  }
  
  void display2(){    
    fill(c);
    noStroke();    
    rectMode(CENTER);
    rect(init_x,init_y,h,w);
    noFill();
    stroke(0);
  
  }

}