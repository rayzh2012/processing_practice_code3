class BoltDrawer {
  PGraphics targetLayer;
  PGraphics boltLayer = createGraphics(width, height, P2D);
  PGraphics glowLayer = createGraphics(width, height, P2D);

  BoltDrawer(PGraphics targetLayer) {
    this.targetLayer = targetLayer;
  }

  void drawBolt(float x, float y, float rot) {

    Node root = new Bolt(0);
    root.trf.translate(x+margin, y+margin);
    root.trf.scale(0.15);
    root.trf.rotate(rot);

    glowLayer.beginDraw();
    glowLayer.smooth();
    glowLayer.colorMode(HSB, 360, 1, 1);  
    glowLayer.background(0);
    
    boltLayer.beginDraw();
    boltLayer.smooth();
    boltLayer.colorMode(HSB, 360, 1, 1);  
    boltLayer.background(0);

    glowLayer.noStroke();
    glowLayer.fill(mainHue, 0.2, 1);
    glowLayer.ellipse(x+margin, y+margin, 30, 30);

    glowLayer.applyMatrix(root.trf);
    boltLayer.applyMatrix(root.trf);

    root.draw(boltLayer, glowLayer);

    glowLayer.endDraw();
    boltLayer.endDraw();
    glowLayer.loadPixels();  
    fastBlur(glowLayer.pixels, 7, width, height);
    boltLayer.blend(glowLayer, 0, 0, width, height, 0, 0, width, height, ADD);
    targetLayer.blend(boltLayer, 0, 0, width, height, 0, 0, width, height, ADD);
    
    /*
    targetLayer.beginDraw();
    targetLayer.noStroke();
    targetLayer.fill(0);
    targetLayer.rect(margin, margin, frameW, frameH);
    targetLayer.endDraw();
    */
  }
}

