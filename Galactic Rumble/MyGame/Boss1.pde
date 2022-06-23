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
class Boss1 extends Actor
{
  final int FORWARD = 0;
  final int BACKWARDS = 0;
  int boss1Health = 15;
  float movementCounter = 0;
  float movementTimer = 0;
  int movementSpeed = 2; //the speed that the boss moves
  //float movementAmount = 2;
  boolean movementState = false; //a boolean that controls forward and backwards movement. False is forwards, true is backwards.
  public Boss1(float x, float y)
  {
    super(x, y, loadImage("boss1_big.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    if (isAtEdge()) { //if boss touches the wall, move backwards.
      movementState = !movementState;
    }
    if (movementState) {
      movementSpeed = 2;
      //movementAmount = 2;
    } else {
      movementSpeed = -2;
      //movementAmount = 0.5;
    }

    //boss1's movement pattern (forward 3 times then step back to give the player a chance to kill it).
    if (movementCounter < 50) {
      setLocation(getX(), getY()-movementSpeed);
      movementCounter++;
      movementTimer = 0;
    } else {
      setLocation(getX(), getY()+movementSpeed);
      movementTimer++;
      if (movementTimer > 25) {
        movementCounter = 0;
        movementTimer = 0;
      }
    }

    hitLaser();
    if (boss1Health <= 0) { //if health runs out, delete character.
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
      boss1Health--;
      getWorld().removeObject(laser);
    }
  }
}
