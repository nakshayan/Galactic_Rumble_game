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
class Explosion extends Actor
{
  int frameCounter = 0;

  public Explosion(float x, float y)
  {
    super(x, y, loadImage("explosion.png"));
  }

  // The code to run for this Actor each frame.
  public void act(float deltaTime) 
  {
    frameCounter++; //count up each frame

    //after 60 frames, remove the explosion.
    if (frameCounter >= 60) {
      getWorld().removeObject(this);
      userState = GAMEOVER;
    }
  }
}
