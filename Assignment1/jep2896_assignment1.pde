int x = 400;
int y = 325;
void setup(){
size(800,650);
background(255);
rectMode(RADIUS);
stroke(0);
strokeWeight(5);
fill(#FFD700);//#FFFF00);
rect(x,y,395,320);
noStroke();
strokeWeight(1);
fill(0);
stroke(#FFFF00);//#FFD700);
strokeWeight(10);
rect(x,y,250,250);
noStroke();
strokeWeight(1);
fill(150);
ellipse(x,y,400,400);
fill(#FFC200);
arc(x,y,400,400,1.1667*PI,2*PI-.1667*PI);
fill(0);
stroke(0);
strokeWeight(2);
arc(x,y,400,400, 1.1667*PI-.08333*.25*PI, 1.1667*PI+.08333*.25*PI);
arc(x,y,400,400, 2*PI-.1667*PI-.08333*.25*PI, 2*PI-.1667*PI+.08333*.25*PI);
noStroke();
strokeWeight(1);
fill(0);
ellipse(x,y,300,300);
fill(150);
int s = 70;
int factor = round(sqrt(3)*.4);
int offset = 30;
stroke(150);
triangle(x - s, y + factor*s - offset,x, y - factor*s - offset, x + s, y + factor*s - offset);

pushMatrix();
translate(width/2, height/2);
rotate(PI-.1667*PI);
rect(100,0,90,30);
popMatrix();
pushMatrix();
translate(width/2, height/2);
rotate(.1667*PI);
rect(100,0,90,30);
popMatrix();
fill(0);

stroke(0);
rect(x,y,10,100);

}