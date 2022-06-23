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
class DangerZone extends Actor
{
  public DangerZone(float x, float y)
  {
    super(x, y, loadImage("dangerZone.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    //no need for code in this section, check the method "hitDangerZone()" in the Player tab for code.
  }
}
