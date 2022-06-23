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
class Level2Background extends Actor
{
  public Level2Background(float x, float y)
  {
    super(x, y, loadImage("spaceBackground21.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    if ((!str((str(userState).charAt(0))).equals("2")) && userState != PAUSE && userState != INTRO && userState != WAITING && userState != READY && userState != GAMEOVER) getWorld().removeObject(this); //If the userState is no longer on level 2, delete the background.
    //println(str((str(userState).charAt(0))));
  }
}
