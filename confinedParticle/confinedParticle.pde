/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/61137*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
PGraphics imgFrame, imgTrail, imgPart, imgBolt;
BoltDrawer bolt;
Particle p;
int margin = 120;
int mainHue = 180;
int frameW;
int frameH;

void setup() {
  size(400, 400);

  frameW = width-2*margin;
  frameH = height-2*margin;

  imgFrame = createGraphics(width, height, P2D);
  imgBolt  = createGraphics(width, height, P2D);
  imgTrail = createGraphics(frameW, frameH, P2D);
  imgPart  = createGraphics(frameW, frameH, P2D);

  p = new Particle(100, 0, 0.2, imgTrail, imgPart);
  bolt = new BoltDrawer(imgBolt);

  //create the background image
  drawFrame();
  image(imgFrame, 0, 0);
}

void draw() {
  image(imgFrame, 0, 0);

  imgTrail.loadPixels();
  fastBlur(imgTrail.pixels, 1, frameW, frameH);

  for (int i = 0; i < 6; i++) {
    p.step();
    p.drawTrail();
  }
  p.drawParticle();

  blendLayers();
  fadeBolts();

  if (frameCount % 200 == 0) {
    p.bias = random(0.02, 0.2);
    p.biasDir = pow(-1, int(random(2)));
  }
}

void blendLayers() {
  blend(imgPart, 0, 0, frameW, frameH, 
  margin, margin, frameW, frameH, ADD);

  blend(imgTrail, 0, 0, frameW, frameH, 
  margin, margin, frameW, frameH, ADD);

  blend(imgBolt, 0, 0, width, height, 
  0, 0, width, height, ADD);  
}

void fadeBolts() {
  imgBolt.beginDraw();
  imgBolt.noStroke();
  imgBolt.fill(0, 90);
  imgBolt.rect(0, 0, width, height);
  imgBolt.endDraw();
}

