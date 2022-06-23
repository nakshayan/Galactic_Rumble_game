import java.util.*;
import Green.*;


HealthBar healthbar; //player's healthbar

int killCounter = 0; //used to count the number of kills the player gets.

//user states that allow the program to swap between levels
final int PAUSE = -1; //pause program (for screens).
final int INTRO = 0; //intro screen
final int WAITING = 1; //waiting for program
final int READY = 2; //waiting for program
final int GAMEOVER = 3; //death screen

//levels numbered as first digit is level, second digit is round, so 11 is level1:round1
final int LEVEL1_ROUND1 = 11;
final int LEVEL1_ROUND2 = 12;
final int LEVEL1_ROUND3 = 13;
final int LEVEL1_ROUND4 = 14;
final int LEVEL1_ROUND5 = 15; //boss round

final int LEVEL2_PAUSE_SCREEN = 20;
final int LEVEL2_ROUND1 = 21;
final int LEVEL2_ROUND2 = 22;
final int LEVEL2_ROUND3 = 23;
final int LEVEL2_ROUND4 = 24;
final int LEVEL2_ROUND5 = 25; //boss round

final int WON = 998;
final int ENDLESS = 999; //endless mode

int time = 0;
int userState = INTRO;

int setBackground = 1; //helps with swapping backgrounds

int killCounterForEndless = 0; //the kill counter for the endless mode (just to make sure everything works)
int randomNumberForSpawn; //For endless mode spawning random enemies

//Initialize enemies.
Enemy1 enemy1; 
CometStorm cometStorm;

class MyWorld extends World
{
  public MyWorld(int w, int h)
  {    
    super(w, h, loadImage("space2.png")); //loads background
  }

  public void prepare()
  {
    Player player = new Player(75, 312); //loads the spaceship (player)
    player.setZ(100);
    addObject(player);

    DangerZone dangerZone = new DangerZone(width/2, height/2+275);
    addObject(dangerZone);

    //add a healthbar for the player's health
    healthbar = new HealthBar(90, 30, 150, 30);
    healthbar.setZ(1000);
    addObject(healthbar);
  }

  public void act(float deltaTime)
  {
    //println(killCounter);
    //println("endless: " + killCounterForEndless);
    println(playerKillCounter);

    //determines what level the player is currently on, based on their number of kills, then switches levels when needed.
    if (killCounter >= 0 && killCounter < 3 && userState != READY) {
      //killCounter = 41;
      userState = LEVEL1_ROUND1;
    } else if (killCounter >= 3 && killCounter < 8 && userState != WAITING) { //for example, if the player is between 3<=killCounter<8 kills, swap to level 3.
      userState = LEVEL1_ROUND2;
    } else if (killCounter >= 8 && killCounter < 9 && userState != READY) {
      userState = LEVEL1_ROUND3;
    } else if (killCounter >= 9 && killCounter < 14 && userState != WAITING) {
      userState = LEVEL1_ROUND4;
    } else if (killCounter >= 14 && killCounter < 15 && userState != READY) {
      userState = LEVEL1_ROUND5; //Boss round
    } else if (killCounter >= 15 && killCounter < 21 && userState != WAITING && userState != LEVEL2_PAUSE_SCREEN && userState != LEVEL2_ROUND1) { //LEVEL 2 START
      userState = LEVEL2_PAUSE_SCREEN;
    } else if (killCounter >= 21 && killCounter < 24 && userState != READY) {
      userState = LEVEL2_ROUND2;
    } else if (killCounter >= 24 && killCounter < 29 && userState != WAITING) {
      userState = LEVEL2_ROUND3;
    } else if (killCounter >= 29 && killCounter < 36 && userState != READY) {
      userState = LEVEL2_ROUND4;
    } else if (killCounter >= 36 && killCounter < 41 && userState != WAITING) {
      userState = LEVEL2_ROUND5;
    } else if (killCounter >= 41 && userState != WON && userState != ENDLESS) {
      userState = WON;
      killCounterForEndless = killCounter;
    }




    time++;
    //println(killCounter);

    //LEVEL 1

    //LEVEL 1, ROUND 1
    if (userState == LEVEL1_ROUND1 && time >= 150) { //starts the round after a few seconds to give the player some time
      //spawns little enemies

      for (int counter = 0; counter < 3; counter++) {
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }
      time = 0;
      userState = READY;
    }

    //LEVEL 1, ROUND 2
    if (userState == LEVEL1_ROUND2) {
      //spawns little enemies
      for (int counter = 0; counter < 5; counter++) { //enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }
      for (int counter = 0; counter < 4; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      time = 0;
      userState = WAITING;
    }

    //LEVEL 1, ROUND 3
    if (userState == LEVEL1_ROUND3) {

      for (int counter = 0; counter < 3; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      //spawns the giant ship
      Enemy2 enemy2 = new Enemy2(width/2, height);
      addObject(enemy2);
      time = 0;
      userState = READY;
    }

    //LEVEL 1, ROUND 4
    if (userState == LEVEL1_ROUND4) {
      for (int counter = 0; counter < 5; counter++) { //spawn enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }

      for (int counter = 0; counter < 4; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }
      time = 0;
      userState = WAITING;
    }

    if (userState == LEVEL1_ROUND5) { //comets
      for (int counter = 0; counter < 3; counter++) {
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }
      //big boss1
      Boss1 boss1 = new Boss1(width/2, height);
      addObject(boss1);
      time = 0;
      userState = READY;
    }

    //LEVEL 2:
    if (userState == LEVEL2_ROUND1) {
      //If lag becomes too much, comment out the background below to reduce the amount of sprites on the screen.
      //change background
      Level2Background level2Background = new Level2Background(width/2, height/2); 
      level2Background.setZ(-1000);
      addObject(level2Background);


      for (int counter = 0; counter < 5; counter++) { //spawn enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }

      for (int counter = 0; counter < 3; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      //spawns the giant ship
      Enemy2 enemy2 = new Enemy2(width/2, height);
      addObject(enemy2);

      time = 0;
      userState = WAITING;
    }

    if (userState == LEVEL2_ROUND2) {
      for (int counter = 0; counter < 2; counter++) { //spawn enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }

      for (int counter = 0; counter < 3; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      //big boss1
      Boss1 boss1 = new Boss1(width/2, height);
      addObject(boss1);

      time = 0;
      userState = READY;
    }

    if (userState == LEVEL2_ROUND3) {
      for (int counter = 0; counter < 4; counter++) { //spawn enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }

      for (int counter = 0; counter < 3; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      //spawns the giant ship
      Enemy2 enemy2 = new Enemy2(width/2, height);
      addObject(enemy2);

      time = 0;
      userState = WAITING;
    }

    if (userState == LEVEL2_ROUND4) {
      for (int counter = 0; counter < 7; counter++) { //spawn enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }

      for (int counter = 0; counter < 3; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      time = 0;
      userState = READY;
    }

    //spawns turret boss
    if (userState == LEVEL2_ROUND5) {
      TurretBoss turretBoss = new TurretBoss(width/2, height/2);
      addObject(turretBoss);

      for (int counter = 0; counter < 4; counter++) { //spawn enemy1
        enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height));
        addObject(enemy1);
      }

      for (int counter = 0; counter < 3; counter++) { //comets
        cometStorm = new CometStorm(width, random(height/2, height-100));
        addObject(cometStorm);
      }

      time = 0;
      userState = WAITING;
    }

    //Endless mode (after game is won).
    if (userState == ENDLESS) {

      //If lag becomes too much, comment out the background below to reduce the amount of sprites on the screen.
      if (setBackground == 1) { //changes background
        EndlessBackground endlessBackground = new EndlessBackground(width/2, height/2);
        endlessBackground.setZ(-1000);
        addObject(endlessBackground);
        setBackground = 0;
      }
      //do the waves of enemies
      if (killCounter >= killCounterForEndless) { //when the player eliminates all the enemies
        killCounterForEndless += 3; //lets the program know when to start the next wave.

        randomNumberForSpawn = int(random(0, 3)); //chooses a random wave each time.

        if (randomNumberForSpawn == 0) { //endless enemy wave 1
          for (int counter = 0; counter < 2; counter++) {
            enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height)); //spawns new enemy1
            addObject(enemy1);
          }

          for (int counter = 0; counter < 3; counter++) { //comets
            cometStorm = new CometStorm(width, random(height/2, height-100));
            addObject(cometStorm);
          }

          TurretBoss turretBoss = new TurretBoss(width/2, height/2);
          addObject(turretBoss);
        } else if (randomNumberForSpawn == 1) { //endless wave 2
          for (int counter = 0; counter < 2; counter++) {
            enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height)); //spawns new enemy1
            addObject(enemy1);
          }

          for (int counter = 0; counter < 3; counter++) { //comets
            cometStorm = new CometStorm(width, random(height/2, height-100));
            addObject(cometStorm);
          }

          Enemy2 enemy2 = new Enemy2(width/2, height);
          addObject(enemy2);
        } else if (randomNumberForSpawn == 2) { //endless wave 3
          for (int counter = 0; counter < 2; counter++) {
            enemy1 = new Enemy1(chooseEnemySpawnPosition(), random(0, height)); //spawns new enemy1
            addObject(enemy1);
          }
          Boss1 boss1 = new Boss1(width/2, height);
          addObject(boss1);

          for (int counter = 0; counter < 3; counter++) { //comets
            cometStorm = new CometStorm(width, random(height/2, height-100));
            addObject(cometStorm);
          }
        }
      }
    }
  }

  //Description: Randomly chooses whether an enemy spawns on the left or right side of the map.
  //Parameters: none.
  //Returns: The x position of the wanted enemy.
  int chooseEnemySpawnPosition() {
    int randomNumber = int(random(0, 2));
    if (randomNumber == 0) return width;
    else return 0;
  }
}
