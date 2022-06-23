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
class EndlessBackground extends Actor
{
  public EndlessBackground(float x, float y)
  {
    super(x, y, loadImage("spaceBackgroundEndless.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
   if (userState != 999 && userState != PAUSE && userState != INTRO && userState != WAITING && userState != READY && userState != GAMEOVER) getWorld().removeObject(this); //If the userState is not on endless mode, delete the background since we don't need it.
  }
}
