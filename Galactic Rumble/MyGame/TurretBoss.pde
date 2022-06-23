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


class TurretBoss extends Actor
{

  int enemy1Health = 5;
  int rocketShootTimer = 100;
  int randomTurnTimer = 0;
  int randomTurnAmount = 2;
  public TurretBoss(float x, float y)
  {
    super(x, y, loadImage("turret.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    //for the turret's functions.
    rocketShootTimer++;
    randomTurnTimer++;

    //call methods
    hitLaser();
    rocketShoot();
    turretRandomMovement();
    //println(rocketShootTimer);

    //when health goes below 0, remove this object.
    if (enemy1Health <= 0) {
      getWorld().removeObject(this);
      killCounter++;
      playerKillCounter++;
    }
  }


  //Description: Takes damage when player hits this enemy.
  //Parameters: Nothing
  //Returns: Nothing.
  void hitLaser() {
    //If the tank is touching the Bullet2 object then decrease the Tank's health.
    Laser laser = getOneIntersectingObject(Laser.class);
    if (laser != null) {
      enemy1Health--;
      getWorld().removeObject(laser);
    }
  }

  //Description: Allows the player to shoot
  //Parameters: Nothing
  //Returns: Nothing.
  void rocketShoot() {
    if (rocketShootTimer >= 100) {
      Rocket rocket = new Rocket(getX(), getY()); //create new laser at turret's position
      rocket.setRotation(getRotation()); //set rotation to turret's rotation
      rocket.move(100);
      getWorld().addObject(rocket); //add laser to the world
      rocketShootTimer = 0;
    }
  }

  //Description: Randomly makes the turret move.
  //Parameters: Nothing
  //Returns: Nothing.
  void turretRandomMovement() {
    //if (randomTurnTimer%10 == 0) {
      turn(randomTurnAmount);
    //}
    if (randomTurnTimer >= 200) {
      if (int(random(1, 3)) == 1) {
        randomTurnAmount*=-1;
        randomTurnTimer = 0;
      } else {
        randomTurnTimer = 0;
      }
    }
  }
}
