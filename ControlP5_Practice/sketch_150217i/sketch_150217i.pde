import hypermedia.video.*;        //  Imports the OpenCV library
OpenCV opencv;                    //  Creates a new OpenCV Object
PImage trailsImg;                 //  Image to hold the trails
int hCycle;                       //  A variable to hold the hue of the image tint
 
void setup()
{
 
  size( 320, 240 );
 
  opencv = new OpenCV( this );    //  Initialises the OpenCV object
  opencv.capture( 320, 240 );     //  Opens a video capture stream
  trailsImg = new PImage( 320, 240 );  //  Initialises trailsImg
  hCycle = 0;                     //  Initialise hCycle
}
 
void draw()
{
 
  opencv.read();                  //  Grabs a frame from the camera
  opencv.absDiff();               //  Calculates the absolute difference
  opencv.convert( OpenCV.GRAY );  //  Converts the difference image to greyscale
  opencv.blur( OpenCV.BLUR, 3 );  //  I like to blur before taking the difference image to reduce camera noise
  opencv.threshold( 20 );
 
 
  trailsImg.blend( opencv.image(), 0, 0, 320, 240, 0, 0, 320, 240, SCREEN );  //  Blends the movement image with the trails image
 
  colorMode(HSB);                 //  Changes the colour mode to HSB so that we can change the hue
  tint(color(hCycle, 255, 255));  //  Sets the tint so that the hue is equal to hcycle and the saturation and brightness are at 100%
  image( trailsImg, 0, 0 );       //  Display the blended difference image
  noTint();                       //  Turns tint off
  colorMode(RGB);                 //  Changes the colour mode back to the default
 
 
 
  opencv.copy( trailsImg );       //  Copies trailsImg into OpenCV buffer so we can put some effects on it
  opencv.blur( OpenCV.BLUR, 4 );  //  Blurs the trails image
  opencv.brightness( -20 );       //  Sets the brightness of the trails image to -20 so it will fade out
  trailsImg = opencv.image();     //  Puts the modified image from the buffer back into trailsImg
 
  opencv.remember();              //  Remembers the current frame
 
  hCycle++;                       //  Increments the hCycle variable by 1 so that the hue changes each frame
  if (hCycle < 255) hCycle = 0;   //  If hCycle is greater than 255 (the maximum value for a hue) then make it equal to 0
}
