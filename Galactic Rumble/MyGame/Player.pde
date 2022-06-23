// ***************************
// All the code for an Actor.
//
// Copy and paste this code into a new tab for
// each Actor you are going to have in your game.
// I.e. Tank, Landmine, Gold, etc...
// Once you have pasted this code into a new tab do:
// #1 - change the class name in 2 places below.
// #2 - change the image file name, the image must be 
//      located in the same folder as your games
//      processing files.

//allows the program to track the player's position
float playerX = 0;
float playerY = 0;

int shootTimer = 0; //used to count frames since last shot
int dangerZoneTimer = 0; //a timer limiting the amount of damage the danger zone can deal.

//weapon types
final int SLOW = 0; 
final int FAST = 1;
int playerWeapon = SLOW;

int playerKillCounter = 0; //the amount of kills where the player actually shot and killed the enemy, for displaying to the player later.

class Player extends Actor
{
  public Player(float x, float y)
  {
    super(x, y, loadImage("ship3.png")); //ship image
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    checkHealth();
    //sets player position (for the program to use).
    playerX = getX();
    playerY = getY();

    shootTimer++; //stops the player from spamming the laser (sets a cooldown for the laser).

    //calls the methods below
    shoot(); //for shooting the laser

    //for hitting enemies
    hitComet(); //for hitting comets.
    hitEnemy1(); //for hitting enemy1
    hitEnemy2(); //for hitting enemy2
    hitBoss1();
    hitRocket();
    hitDangerZone();

    //movement system
    turnTowards(mouseX, mouseY); //aims the player where the mouse is
    if (Green.getInstance().isKeyDown('a') || Green.getInstance().isKeyDown('A')) { //lets player move using 'w' 'a' 's' and 'd'
      setLocation(getX()-6, getY()); //move left
      //turnTowards(0, getY());
    }
    if (Green.getInstance().isKeyDown('d') || Green.getInstance().isKeyDown('D')) { //move right
      //turnTowards(width, getY());
      setLocation(getX()+6, getY());
    }
    if (Green.getInstance().isKeyDown('w') || Green.getInstance().isKeyDown('W')) { //move up
      setLocation(getX(), getY()-6);
    }
    if (Green.getInstance().isKeyDown('s') || Green.getInstance().isKeyDown('S')) { //move down
      setLocation(getX(), getY()+6);
    }

    //weapon selection system
    if (Green.getInstance().isKeyDown('1')) {
      playerWeapon = SLOW;
    } else if (Green.getInstance().isKeyDown('2')) {
      playerWeapon = FAST;
    }
  }

  //Description: Allows the player to shoot
  //Parameters: Nothing
  //Returns: Nothing.
  void shoot() {
    if (playerWeapon == SLOW) { // a slow but accurate weapon
      if (Green.getInstance().isKeyDown(' ') && shootTimer >= 35) {
        shootTimer = 0;
        Laser laser = new Laser(getX(), getY()); //create new laser at player's position
        laser.setRotation(getRotation()); //set rotation to players's rotation
        laser.move(75);
        getWorld().addObject(laser); //add laser to the world
      }
    } else if (playerWeapon == FAST) { // a fast but unprecise weapon
      if (Green.getInstance().isKeyDown(' ') && shootTimer >= 12) {
        shootTimer = 0;
        Laser laser = new Laser(getX(), getY()); //create new laser at player's position
        laser.setRotation(getRotation()); //set rotation to players's rotation
        laser.move(75);
        laser.turn(random(-25, 25));
        getWorld().addObject(laser); //add laser to the world
      }
    }
  }

  //Description: Allows the player to take damage from enemy1 (small spaceship).
  //Parameters: Nothing
  //Returns: Nothing.
  void hitEnemy1() {
    //If the player is touching the enemy1 object then decrease the player's health.
    Enemy1 enemy1 = getOneIntersectingObject(Enemy1.class);
    if (enemy1 != null) {
      getWorld().removeObject(enemy1);
      healthbar.add(-10); //take away the enemy and 10 health
      killCounter++; //adds one to the killCounter for game for the program to know when to do certain things
    }
  }

  //Description: Allows the player to take damage from enemy2 (big spaceship).
  //Parameters: Nothing
  //Returns: Nothing.
  void hitEnemy2() {
    //same as hitEnemy1 except it takes away 30 health instead of 10 (since the enemy is stronger).
    Enemy2 enemy2 = getOneIntersectingObject(Enemy2.class);
    if (enemy2 != null) {
      //if hit, take away health, remove enemy, add 1 to killCounter, etc.
      getWorld().removeObject(enemy2);
      healthbar.add(-30);
      killCounter++;
    }
  }

  //Description: Allows the player to take damage from boss1 (eye monster).
  //Parameters: Nothing
  //Returns: Nothing.
  void hitBoss1() {
    //same as hitEnemy1 except it takes away 30 health instead of 10 (since the enemy is stronger).
    Boss1 boss1 = getOneIntersectingObject(Boss1.class);
    if (boss1 != null) {
      //if hit, take away health, remove enemy, add 1 to killCounter, etc.
      getWorld().removeObject(boss1);
      healthbar.add(-50);
      killCounter++;
    }
  }

  //Description: Allows the player to take damage from comets.
  //Parameters: Nothing
  //Returns: Nothing.
  void hitComet() {
    //If the player is touching the enemy1 object then decrease the player's health.
    CometStorm cometStorm = getOneIntersectingObject(CometStorm.class);
    if (cometStorm != null) {
      getWorld().removeObject(cometStorm);
      healthbar.add(-10); //take away the enemy and 10 health
    }
  }

  //Description: Allows the player to take damage from rockets.
  //Parameters: Nothing
  //Returns: Nothing.
  void hitRocket() {
    //if player is touching rocket, take damange and delete rocket.
    Rocket rocket = getOneIntersectingObject(Rocket.class);
    if (rocket != null) {
      getWorld().removeObject(rocket);
      healthbar.add(-10); //take away the enemy and 10 health
    }
  }

  //Description: Makes player take damage when in the danger zone.
  //Parameters: Nothing
  //Returns: Nothing.
  void hitDangerZone() {
    DangerZone dangerZone = getOneIntersectingObject(DangerZone.class);
    if (dangerZone != null) {
      dangerZoneTimer++;
    }

    if (dangerZoneTimer >= 50) {
      healthbar.add(-5); //if a certain amount of time has passed and the player is still in the danger zone, deal damage.
      dangerZoneTimer = 0;
    }
  }

  //Description: Removes the player once it runs out of health and replaces it with an explosion.
  //Parameters: Nothing
  //Returns: Nothing.
  void checkHealth() {
    //if the tank's healthbar is at zero, then create an explosion and remove the tank.
    if (healthbar.getValue() <= 0) {
      Explosion explosion = new Explosion(getX(), getY());
      getWorld().addObject(explosion);
      getWorld().removeObject(this);
    }
  }
}
