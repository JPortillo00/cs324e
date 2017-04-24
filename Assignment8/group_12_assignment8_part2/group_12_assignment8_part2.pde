import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

Table table;
float[] x;
float[] y;
float[] z;

PeasyCam camera;

void setup() {
  size(1200,1000,P3D);
  noSmooth();
  table = loadTable("2010_Census_Populations_by_Zip_Code.csv", "header");

  x = new float[table.getRowCount()];
  y = new float[table.getRowCount()];
  z = new float[table.getRowCount()];
  
  line(0,0,1200,0);
  line(0,0,0,100);
  int count = 0;
  
  for (TableRow row : table.rows()) {
    x[count] = table.getFloat(count,"Total Population")/100;
    y[count] = table.getFloat(count,"Median Age")*10;
    z[count] = table.getFloat(count,"Average Household Size")*-100;
    
    
    count++;
    
  }
  
  camera = new PeasyCam(this, 500,500,0, 1000);
}
  
void draw() {
  background(0);
  stroke(255);
  
  int count = 0;
  
  
  for (int i = 0; i < table.getRowCount(); i++) {
    int k = i+1;
    if(k>= table.getRowCount()){
      break;
    }
    else{
    line(x[i],y[i],z[i],x[k],y[k],z[k]); 
    }
  }
  textSize(32);
  text("Total Population in hundreds", 600, 50, 0);
  text("Median Age(scaled by ten)", 50,800, 0);
  text("Average Household Size(Scaled by one hundred)", 50,0,-500);
  for(int i = 0; i<1200;i++){
    if(i%20 == 0){
      line(i, 0, i, 10);
      textSize(8);
      
      text(count*20,i,20,0);
      count++;
    }
  }
  count = 0;
  for(int i = 0; i<1000;i++){
    if(i%20 == 0){
      line(0, i, 10, i);
      textSize(8);
      
      text(count*20,20,i,0);
      count++;
    }
  }
  count = 0;
  for(int i =-1000; i<0;i++){
    if(i%10 == 0){
      line(0, 0, i, 10,0,i);
      textSize(8);
      
      text(1000-count*10,20,0,i);
      count++;
    }
  }
}