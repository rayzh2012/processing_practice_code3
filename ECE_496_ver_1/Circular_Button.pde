class CircularButton implements ControllerView<Button> {

  public void display(PApplet theApplet, Button theButton) {
    theApplet.pushMatrix();
    if (theButton.isInside()) {
      if (theButton.isPressed()) { // button is pressed
        theApplet.fill(200, 60, 0);
      }  else { // mouse hovers the button
        theApplet.fill(200, 160, 100);
      }
    } else { // the mouse is located outside the button area
      theApplet.fill(0, 160, 100);
    }
    
    theApplet.ellipse(0, 0, theButton.getWidth(), theButton.getHeight());
    
    // center the caption label 
    int x = theButton.getWidth()/2 - theButton.getCaptionLabel().getWidth()/2;
    int y = theButton.getHeight()/2 - theButton.getCaptionLabel().getHeight()/2;
    
    translate(x, y);
    theButton.getCaptionLabel().draw(theApplet);
    
    theApplet.popMatrix();
  }
}


/*
a list of all methods available for the ControllerView Controller
use ControlP5.printPublicMethodsFor(ControllerView.class);
to print the following list into the console.

You can find further details about class ControllerView in the javadoc.

Format:
ClassName : returnType methodName(parameter type)

controlP5.ControllerView : void display(PApplet, T)

*/

