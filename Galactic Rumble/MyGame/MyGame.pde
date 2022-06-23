//Name: Action
//Date: Tuesday, June 21, 2022
//Description A space game.

import Green.*;

Green green;
MyWorld world;

//variables for intro screen pictures
PImage screen;
PImage spaceShip;
PImage spaceShipEnemy;
//PFont systemFont;


void setup() { 

  //sets game background and size
  size(640, 940);
  screen = loadImage("space_start.png"); //intro screen image
  spaceShip = loadImage("ship3.png");
  spaceShipEnemy = loadImage("enemy1.png");
  //systemFont = createFont("Georgia", 40); //intro screen text

  //the intro screen
  background(255, 0, 0);
  image(screen, 0, 0);

  //text
  fill(91, 132, 177); 
  rect(width/2-250, height/2-250, 500, 500);
  fill(252, 118, 106);
  //textFont(systemFont);
  textSize(35);
  textAlign(CENTER);
  text("Welcome to Galactic Rumble", width/2, height/2-200);
  textSize(30);
  fill(252, 118, 106);
  textAlign(LEFT);
  text("CONTROLS:", width/2-200, height/2 - 130);
  text("W - move up", width/2-200, height/2 - 80);
  text("A - move left", width/2-200, height/2 - 40);
  text("S - move down", width/2-200, height/2);
  text("D - move down", width/2-200, height/2 + 40);
  text("SPACE - shoot laser", width/2-200, height/2 + 80);
  text("Aim with the mouse", width/2-200, height/2 + 120);
  textSize(25);
  text("Use '1' and '2' to swap weapons", width/2-200, height/2+160);
  //text("'1' for a slow weapon good for small enemies", width/2-200-40, height/2+170);
  //text("'2' for a fast weapon good for big enemies", width/2-200-40, height/2+195);
  textAlign(CENTER);
  textSize(35);
  text("Press \'E\' to start", width/2, height/2+230);
  image(spaceShip, 50, 100);
  image(spaceShipEnemy, width-150, 100);
  textSize(20);
  text("Weapon \'1\' is great for small enemies", width/2, height-180);
  text("Weapon \'2\' is great for big enemies and groups", width/2, height-150);
  textSize(35);
  text("Don't enter the danger zone!", width/2, height-70);
  text("You lose health.", width/2, height-20);

  //initialization stuff
  green = new Green(this);
  world = new MyWorld(width, height);
  green.loadWorld(world);
}

void draw()
{
  if (userState != INTRO && userState != GAMEOVER && userState != PAUSE && userState != LEVEL2_PAUSE_SCREEN && userState != WON) { //stops the game during intro and death.
    green.handleAct();
    green.handleDraw();
    green.handleMousePosition(pmouseX, pmouseY, mouseX, mouseY);
    green.handleInput();
  } else if (userState == LEVEL2_PAUSE_SCREEN) { //level 1 completed screen
    image(screen, 0, 0);
    //text
    fill(91, 132, 177); 
    rect(width/2-250, height/2-250, 500, 500);
    fill(252, 118, 106);
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Congratulations!", width/2, height/2-50);
    text("You beat level 1.", width/2, height/2);
    text("Press \'E\' to continue.", width/2, height/2+50);
  } else if (userState == WON) { //game won screen
    image(screen, 0, 0);
    //text
    fill(91, 132, 177); 
    rect(width/2-250, height/2-250, 500, 500);
    fill(252, 118, 106);
    textSize(40);
    textAlign(CENTER, CENTER);
    text("Congratulations!", width/2, height/2-100);
    text("You win!", width/2, height/2-50);
    text("Play endless:", width/2, height/2+50);
    text("Press \'E\'", width/2, height/2+100);
  } else if (userState == GAMEOVER) { //death screen
    //death screen
    image(screen, 0, 0);
    //text
    fill(91, 132, 177); 
    rect(width/2-250, height/2-250, 500, 500);
    fill(252, 118, 106);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("You died.", width/2, height/2-50);
    text("Game over!", width/2, height/2+50);
    text("Kills: " + playerKillCounter, width/2, height-100);

    textSize(30);
    text(randomDeathMessage[int(random(0, randomDeathMessage.length))], width/2, height/2+150); //display a random death message
    userState = PAUSE;
  }
}

//Death messages (chosen at random).
String[] randomDeathMessage = {
  "Nice try...", 
  "Maybe next time", 
  "Try to do better?", 
  "Good attempt!", 
  "Good effort.", 
  "Again?", 
  "Could've done better...", 
  "Meh...", 
  "Also play asteroids!", 
  "A fine ship for my collection...", 
  "Ay! I'm flyin' here! I'm flyin' here!", 
  "Houston, we have a problem.", 
  "E.T. can't phone home anymore :(", 
  "Name's ship. Space ship.", 
  "You'll be back... right?", 
  "It's not rocket science... wait...", 
  "Elementary, my dear player.", 
  "You were a spacehip, Harry.", 
  "I don't feel so good..."
};

//for easy access to button presses
void mousePressed()
{
  green.handleMouseDown(mouseButton);
}
void mouseReleased()
{
  green.handleMouseUp(mouseButton);
}
void mouseWheel(MouseEvent event)
{
  green.handleMouseWheel(event.getCount());
}
void keyPressed()
{
  green.handleKeyDown(key, keyCode);
}
void keyReleased()
{
  if (key == 'e' || key == 'E') { //swaps between win screens
    if (userState == INTRO) userState = LEVEL1_ROUND1; //intro to level 1
    else if (userState == LEVEL2_PAUSE_SCREEN) {
      userState = LEVEL2_ROUND1; 
      healthbar.add(100);
    } //level 1 to level 2
    else if (userState == WON) { 
      userState = ENDLESS;
      healthbar.add(100);
    } //endless mode screen
  }
  green.handleKeyUp(key, keyCode);
}
