import processing.sound.*;
SoundFile file, pop;

Grid grid;
Shooter shooter;
boolean gameFinished = false;
RectButton [] button = new RectButton[3];
boolean locked = false;
color currentcolor, buttoncolor, highlight;
boolean paused = false;


void setup() {
  //sound objects
  file = new SoundFile(this,"groove.mp3");
  pop = new SoundFile(this,"pop.mp3");
  
  size(670, 800); //Hardcoded to look decent with the edge sizes
  buttoncolor = color(102);
  highlight = color(51); 
  button[0] = new RectButton(335, 250, 85, 30, buttoncolor, highlight, "Resume");
  button[1] = new RectButton(335, 300, 125, 30, buttoncolor, highlight, "New Game");
  button[2] = new RectButton(335, 350, 60, 30, buttoncolor, highlight, "Exit");
  grid = new Grid(12, 10, 60);
  shooter = new Shooter(grid);
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 10; j++) {
      grid.addBubble(i, j, randomColor());
    }
  }
  //Test: Remove some at random
  /*
  for (int k = 0; k < 0; k++) {
   int ri = (int)(random(6));
   int rj = (int)(random(10));
   boolean rem = grid.removeBubble(ri, rj);
   //println(ri, rj, rem);
   }
   */
   file.play();
}

void update(int x, int y) {
  if (locked == false) {
    button[0].update();
    button[1].update();
    button[2].update();
  } else {
    locked = false;
  }
  if (mousePressed && paused) {
    if (button[0].pressed()) {
      paused = false;
      shooter.paused = paused;
    } else if (button[1].pressed()) {
      paused = false;
      shooter.paused = paused;
      gameFinished = true;
    } else if (button[2].pressed()) {
      exit();
    }
  }
}

void Paused() {
  paused = true;
  shooter.paused = paused;
  shooter.togglePause();
  update(mouseX, mouseY);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  stroke(255);
  fill(currentcolor);
  rect(335, 150, 150, 60);
  fill(255);
  text("Paused", 335, 150);
  button[0].display();
  button[1].display();
  button[2].display(); 
  rectMode(CORNER);
  textAlign(BASELINE);
}

void draw() {
  background(0);
  if (!gameFinished) {
    grid.update();
  }
  if (grid.win || grid.lose) {
    gameFinished = true;
  }
  grid.render();
  if (!gameFinished) {
    shooter.update();
  }
  shooter.render();

  ///*
  //Testing the collision detection with the mouse
  int[] indices = grid.getClosestIndices(mouseX, mouseY);

  //Definitely shouldn't be in the final version lol
  if (mousePressed && (mouseButton == LEFT)) {
    grid.collide(mouseX, mouseY, randomColor());
  } else if (mousePressed && (mouseButton == RIGHT)) {
    ArrayList<Bubble> connected = grid.getConnectedBubbles(indices[0], indices[1]);
    for (Bubble b : connected) {
      int[] ind = grid.getClosestIndices(b.getX(), b.getY()); //This is really ineffecient but whatever
      grid.removeBubble(ind[0], ind[1]);
    }
  }
  //*/
  if (paused) {
    Paused();
    file.stop();
  }

  //Keyboard input
  if (keyPressed) {
    if (!gameFinished) {
      if (key == ' ') {
        shooter.shoot();
      } else if (key == 'z') {
        shooter.toggleGuide();
      } else if (key == 'x') {        
        paused = !paused;
        shooter.paused = paused;
        
      } else if (key == CODED) {
        if (keyCode == LEFT) {
          shooter.increaseAngle();
        } else if (keyCode == RIGHT) {
          shooter.decreaseAngle();
        }
      }
    } else {
      gameFinished = false;
      //Reset game
      shooter.reset();
      grid.reset();
      file.stop();
      file.play();
      for (int i = 0; i < 6; i++) {
        for (int j = 0; j < 10; j++) {
          grid.addBubble(i, j, randomColor());
        }
      }
    }
  }
}

public color randomColor() {
  color[] colors = {color(255, 0, 0), color(255, 255, 0), color(0, 255, 0), color(0, 255, 255), color(0, 0, 255), color(255, 0, 255)};
  int r = (int)random(6);
  return colors[r];
}