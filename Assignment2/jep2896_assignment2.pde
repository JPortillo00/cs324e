PImage img1;
PImage img2;
float red,blue,green;
void setup(){
  surface.setResizable(true); 
  img1 = loadImage("ABTrump.jpg"); 
  surface.setSize(img1.width, img1.height);  
  img2 = createImage(img1.width, img1.height,ARGB);
  
}
int input = 0; 
void draw(){  
  if (keyPressed){
    if (key == '0'){
      Original();
      image(img2,0,0);
    }else if (key == '1'){
      GrayScale();
      image(img2,0,0);    
    }else if (key =='2'){
      Contrast();
      image(img2,0,0);
    }else if (key == '3'){
      Gaussian();
      image(img2,0,0);
    }else if (key == '4'){
      EdgeDetection();
      image(img2,0,0);
    } else{
      Original();
      image(img2,0,0);
    } 
  
  }
 

}


void Original(){
  img1.loadPixels();
  img2.loadPixels();
  for (int x = 0; x < img2.width; x++){
     for (int y = 0; y<img2.height;y++){
       int loc = x+y*img2.width;
       img2.pixels[loc] = img1.pixels[loc];
       
     }
  }
  img1.updatePixels();
  img2.updatePixels();
}

void GrayScale(){
  img1.loadPixels();
  img2.loadPixels();
  for (int x = 0; x < img2.width; x++){
     for (int y = 0; y<img2.height;y++){
       int loc = x+y*img2.width;
       red = red(img1.pixels[loc]);
       green = green(img1.pixels[loc]);
       blue = blue(img1.pixels[loc]);
       img2.pixels[loc] = color((red + blue + green)/3);
       
     }
  }
  img1.updatePixels();
  img2.updatePixels();
}

void Contrast(){
  img1.loadPixels();
  img2.loadPixels();
  float threshold = 150;
  for (int x = 0; x < img2.width; x++){
     for (int y = 0; y<img2.height;y++){
       int loc = x+y*img2.width;
       if (brightness(img1.pixels[loc]) > threshold){
         img2.pixels[loc] = color(255);       
       }else{
         img2.pixels[loc] = color(0);
       }
       
       
     }
  }
  img1.updatePixels();
  img2.updatePixels();
}

void Gaussian(){
  float[][] matrix = {{.0625, .125, .0625}, {.125, .25, .125}, {.0625, .125, .0625}};
 
  Original();
  img1.loadPixels();
  img2.loadPixels();
  loadPixels();
  for (int x = 0; x < img2.width; x++){
     for (int y = 0; y<img2.height;y++){
       color c = Convolutions(x,y,matrix,matrix[0].length);
       int loc = x+y*img2.width;
       img2.pixels[loc]=c;       
     }
  }
  updatePixels();
  img1.updatePixels();
  img2.updatePixels();
}

color Convolutions(int x,int y,float[][] matrix, int matrixsize){
  colorMode(RGB);
  red = 0;
  green = 0;
  blue = 0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j = 0; j < matrixsize; j++){
      int loc = (x+i-offset) + img1.width*(y+j-offset);      
      loc = constrain(loc,0,img1.pixels.length-1);
      red += red(img1.pixels[loc])*matrix[i][j];
      green += green(img1.pixels[loc])*matrix[i][j];
      blue += blue(img1.pixels[loc])*matrix[i][j];      
    }
  }
  red = constrain(abs(red),0,255);
  green = constrain(abs(green),0,255);
  blue = constrain(abs(blue),0,255);
  return color(red,green,blue);
}

void EdgeDetection(){
  float[][] sobelx = {{-1, 0, 1}, {-2,0,+2}, {-1,0,1}};
  float[][] sobely = {{-1,-2,-1},{0,0,0},{1,2,1}};
  int matrixsize = 3;  
  img1.loadPixels();
  img2.loadPixels();
  for (int x = 0; x < img2.width; x++){
     for (int y = 0; y<img2.height;y++){
       int index = x+y*img2.width;
       img2.pixels[index] = Sobel(x,y,sobelx,sobely,matrixsize);
     }
   }
    img1.updatePixels();
    img2.updatePixels();
}

color Sobel(int x,int y, float[][] sobelx, float[][]sobely,int matrixsize){
  float pixelxr = 0;
  float pixelxg = 0;
  float pixelxb = 0;
  float pixelyr = 0;
  float pixelyg = 0;
  float pixelyb = 0;
  int offset = matrixsize / 2;
  for (int i = 0; i < matrixsize; i++){
    for (int j = 0; j < matrixsize; j++){
      int loc = (x+i-offset) + img1.width*(y+j-offset);
      loc = constrain(loc,0,img1.pixels.length-1);
      pixelxr += red(img1.pixels[loc])*sobelx[i][j];
      pixelxg += green(img1.pixels[loc])*sobelx[i][j];
      pixelxb += blue(img1.pixels[loc])*sobelx[i][j];
      pixelyr += red(img1.pixels[loc])*sobely[i][j];
      pixelyg += green(img1.pixels[loc])*sobely[i][j];
      pixelyb += blue(img1.pixels[loc])*sobely[i][j];
    }
  }
  float valr = sqrt(pixelxr*pixelxr + pixelyr*pixelyr);
  float valg = sqrt(pixelxg*pixelxg + pixelyg*pixelyg);
  float valb = sqrt(pixelxb*pixelxb + pixelyb*pixelyb);
  
  valr = constrain(valr,0,255);
  valg = constrain(valg,0,255);
  valb = constrain(valb,0,255);
  return color(valr,valg,valb);
}