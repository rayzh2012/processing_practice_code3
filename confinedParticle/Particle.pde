class Particle {
  float dir;
  float x, y;
  float px, py;
  float step = 10;
  int xmax, ymax;
  PGraphics trailLayer, partLayer;
  float bias = random(0.02,0.2);
  float biasDir = pow(-1,int(random(2)));

  Particle(float x, float y, float dir, PGraphics trailLayer, PGraphics partLayer) {
    this.x=x;
    this.y=y;
    this.px=x;
    this.py=y;
    this.dir=dir;
    this.trailLayer = trailLayer;
    this.partLayer = partLayer;
    xmax = frameW;
    ymax = frameH;
  }

  void step() {
    px = x;
    py = y;
    x += sin(dir)*step;
    y += cos(dir)*step;
    if (x > xmax) {
      x = x-2*(x-xmax); 
      dir=-dir;
      bolt.drawBolt(x,y,-PI/2);
    }
    if (x < 0) {
      x = -x;  
      dir=-dir;
      bolt.drawBolt(x,y,PI/2);
    }
    if (y > ymax) {
      y = y-2*(y-ymax);
      dir=PI-dir;
      bolt.drawBolt(x,y,0);
    }
    if (y < 0) {
      y = -y;   
      dir=PI-dir;
      bolt.drawBolt(x,y,PI);
    }

    dir += random(-0.05, 0.05+bias)*biasDir;
  }

  void drawTrail() {
    trailLayer.beginDraw();
    trailLayer.colorMode(HSB, 360, 1, 1);
    trailLayer.smooth();
    trailLayer.fill(0, 0);
    trailLayer.noStroke();
    trailLayer.rect(0, 0, frameW, frameH);

    trailLayer.stroke(mainHue, 0.3, 1);
    trailLayer.strokeWeight(3); 
    trailLayer.line(px, py, x, y); 

    trailLayer.stroke(180, 0, 1);
    trailLayer.strokeWeight(1);
    trailLayer.line(px, py, x, y);
    trailLayer.endDraw();
  }
  void drawParticle() {
    partLayer.beginDraw();
    partLayer.smooth();
    partLayer.background(0);
    partLayer.fill(255);
    partLayer.noStroke();
    partLayer.translate(x,y);
    partLayer.rotate(-dir);
    partLayer.ellipse(0, 0, 8, 18);
    partLayer.loadPixels();
    fastBlur(partLayer.pixels, 6, frameW, frameH);
    partLayer.ellipse(0, 0, 8, 20);
    partLayer.endDraw();
  }

}

