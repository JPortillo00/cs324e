class Label {
  
  Label(String txt1, String txt2, float x, float y) {
    
    // get text width
    float labelW1 = textWidth(txt1 + ": ");
    float labelW2 = textWidth(txt2);
    
    // check if label would go beyond screen dims
    if (x + labelW2 + 20 > width) {
      x -= labelW2 + 20;
    }
    
    // draw bg
    fill(255);
    noStroke();
    rectMode(CORNER); // note: this is the default mode. confusing b/c similar to CORNERS (plural)
    rect(x-40, y-30, labelW1+10, 22);
     rect(x+10, y-30, labelW2+10, 22); 
    
    // draw text
    fill(0);
    text(txt1 + ": ", x-35, y-15);
    text(txt2, x+15, y-15);
  }
}