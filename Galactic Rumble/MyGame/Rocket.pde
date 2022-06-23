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
class Rocket extends Actor
{
  public Rocket(float x, float y)
  {
    super(x, y, loadImage("rocketForTurret.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    //move forward until hit wall
    move(8);

    //if laser hits the wall, delete.
    if (isAtEdge()) {
      getWorld().removeObject(this);
    }
  }
}
