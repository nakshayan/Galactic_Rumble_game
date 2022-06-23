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

//THE SMALL SPACESHIP
class Enemy1 extends Actor
{
  public Enemy1(float x, float y)
  {
    super(x, y, loadImage("enemy1.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    turnTowards(playerX, playerY);
    move(1);
    hitLaser();
  }

  //Description: Takes damage when player hits this enemy.
  //Parameters: Nothing
  //Returns: Nothing.
  void hitLaser() {
    //If the tank is touching the Bullet2 object then decrease the Tank's health.
    Laser laser = getOneIntersectingObject(Laser.class);
    if (laser != null) {
      //remove both laser and enemy
      getWorld().removeObject(this);
      getWorld().removeObject(laser);
      //increases kill counters
      killCounter++;
      playerKillCounter++;
    }
  }
}
