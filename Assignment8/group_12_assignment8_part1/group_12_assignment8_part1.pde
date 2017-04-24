float[] values;
String[] dates;
float plotX1, plotX2, plotY1, plotY2;
int leftMargin = 80;
int topMargin = 100;
int plotHeight = 250;
float timer = 0.0;
PFont helvetica;
Table table;
void setup(){
  table = loadTable("GOOG_data.csv","header");
  values = new float[table.getRowCount()];
  dates = new String[table.getRowCount()];
  int k = 0;
  for (TableRow row : table.rows()) {
    if (k >= table.getRowCount()){
      break;
    }        
    values[k] = row.getFloat("Value");
    dates[k] = row.getString("Date");    
    k++;
  }
  for (int i = 0; i < values.length/2; i++){  
    float temp1 = values[i];
    values[i] = values[values.length-1-i];
    values[values.length-1-i] = temp1;
    
    String temp2 = dates[i];
    dates[i] = dates[values.length-1-i];
    dates[dates.length-1-i] = temp2;
    
    println(i + " " +dates[i] + ": " + values[i]);
    
  }
  
  size(800,600);
  smooth();
  helvetica = createFont("Helvetica-Bold", 14);
  textFont(helvetica); 
  // set plot size
  plotX1 = leftMargin;//80
  plotX2 = width - leftMargin/5;// 800 - 80/5 = 800 - 16 = 784
  plotY1 = topMargin;//100
  plotY2 = height - topMargin ;//600 - 100 = 500
  plotHeight = (int)(plotY2 - plotY1);
  //dx = 784/153 = 5.12
  //dy = 400/153 = 2.61
}

void draw() {
  background(0);
  
  // draw plot bg
  fill(40);
  noStroke();
  rectMode(CORNERS);
  rect(plotX1, plotY1, plotX2, plotY2);  
  noFill();
  stroke(255);
  strokeWeight(2);  
 
  beginShape();  
  float x, y;
  fill(255);
  textAlign(CENTER); 
  for (int i = 0; i < values.length; i++) {
    x = map(i, 0, values.length-1, plotX1, plotX2);
    y = map(values[i], 0, 850, height - topMargin, height - topMargin - plotHeight);
    vertex(x, y);     
    if(dates[i].equals("08/04")){
      line(x,plotY2 -5,x,plotY2 +5);
      text(dates[i],x - 20,plotY2 + 20);
    }else if(dates[i].startsWith("01")){
      line(x,plotY2 -5,x,plotY2 +5);
      text(dates[i],x,plotY2 + 20);
    }   
    
  }
  for (int i = 0; i <= 850; i++){
    y = map(i,0,850,height - topMargin, height - topMargin - plotHeight);
    if(i%50 == 0){
      text(i,60,y + 5);
      line(plotX1,y,plotX2,y);      
    }
  }
  
  noFill();
  textAlign(BASELINE);
  endShape();
  
  // draw points on mouse over
  for (int i = 0; i < values.length; i++) {
    x = map(i, 0, values.length-1, plotX1, plotX2);
    y = map(values[i], 0, 850, height - topMargin, height - topMargin - plotHeight);
       
    // check mouse pos
    // float delta = dist(mouseX, mouseY, x, y);
    float delta = abs(mouseX - x);
    if ((delta < 2) && (y > plotY1) && (y < plotY2)) {
      stroke(255);
      fill(0);
      ellipse(x, y, 8, 8);
      
      int labelVal = round(values[i]);
      Label label = new Label(dates[i],"" + labelVal, x, y);
    }
  }  
  fill(255); 
  textSize(26);
  text("Google Exchange History",250,50);
  textSize(16);
  text("Month/Year",375,575);  
  textSize(14);
  pushMatrix();
  translate(400,300);
  rotate(-PI/2);
  text("Adjusted Closure",-50,-380);
  popMatrix();
}