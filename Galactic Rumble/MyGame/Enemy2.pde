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

//THE BIG SPACESHIP
class Enemy2 extends Actor
{
  int enemy1Health = 5;
  public Enemy2(float x, float y)
  {
    super(x, y, loadImage("bigspaceship.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    turnTowards(playerX, playerY);
    move(1.5);
    hitLaser();
    if (enemy1Health <= 0) { //if the enemy has run out of health, delete enemy.
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
}
