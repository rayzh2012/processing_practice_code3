float x,y,z;

void setup() {
  size(800,800,P3D);
  background(0);
  x = width/2;
  y = height/2;
  z = 0;
}

void draw() {
  
  //size(,360,P3D);
//background(0);
//lights();

pushMatrix();
translate(130, height/2, 0);
rotateY(1.25);
rotateX(-0.4);
noStroke();
box(100);
popMatrix();

pushMatrix();
translate(500, height*0.35, -200);
noFill();
stroke(255);
sphere(280);
popMatrix();

}

