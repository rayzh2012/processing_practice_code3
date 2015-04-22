// draws the background image into the PGraphics imgFrame 
// takes a while, but is only done once

void drawFrame() {
  
  // a blurry glow that will be blended into imgFrame
  PGraphics frameGlow = createGraphics(width, height, P2D);
  frameGlow.beginDraw();
  frameGlow.background(0);
  frameGlow.colorMode(HSB, 360, 1, 1);

  frameGlow.fill(0, 0);
  frameGlow.strokeWeight(50);
  frameGlow.stroke(mainHue, 0.5, 1);
  frameGlow.rect(margin, margin, width-margin*2, height-margin*2);

  frameGlow.fill(mainHue, 0.5, 1);
  frameGlow.noStroke();
  frameGlow.rectMode(CENTER);
  frameGlow.rect(margin, margin, 50, 50);
  frameGlow.rect(width-margin, margin, 50, 50);
  frameGlow.rect(margin, height-margin, 50, 50);
  frameGlow.rect(width-margin, height-margin, 50, 50);
  frameGlow.filter(BLUR, 50); //####################ska vara 50

  frameGlow.fill(0, 0);
  frameGlow.strokeWeight(20);  
  frameGlow.stroke(mainHue, 0.5, 0.9);
  frameGlow.rectMode(CORNER);
  frameGlow.rect(margin, margin, width-margin*2, height-margin*2);
  frameGlow.filter(BLUR, 6);
  frameGlow.filter(BLUR, 2);

  //draw a gradient.
  imgFrame.beginDraw();
  imgFrame.colorMode(HSB, 360, 1, 1);
  for (int i = 5; i > 0; i--) {
    imgFrame.fill(0, 0);
    imgFrame.strokeWeight(i);
    imgFrame.stroke(mainHue, i/5.+0.2, 1);
    imgFrame.rect(margin, margin, width-margin*2, height-margin*2);
  }
  imgFrame.loadPixels();
  imgFrame.filter(BLUR, 3);
  imgFrame.strokeWeight(2);
  imgFrame.rect(margin, margin, width-margin*2, height-margin*2);
  imgFrame.blend(frameGlow, 0, 0, width, height, 0, 0, width, height, ADD);
  imgFrame.endDraw();
}
