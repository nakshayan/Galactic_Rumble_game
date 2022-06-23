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
class CometStorm extends Actor
{
  public CometStorm(float x, float y)
  {
    super(x, y, loadImage("comet2.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    //move until hit wall
    move(-6);
    turn(-0.2);

    //once hit wall, delete itself.
    if (isAtEdge()) {
      getWorld().removeObject(this);
    }
  }
}
