/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/191396*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
class circulo {
  float x, y, radius;
  
  circulo(float _x, float _y) {
    x = _x;
    y = _y;
  }
  
  void run(float _radius) {
    radius = _radius;
    desenha();
  }
  
  void desenha() {
    fill(#E5FCC2);
    ellipse(x, y, radius, radius);
  }
  
}

int numeroCirculos = 30;
circulo[] circuloArray = new circulo[numeroCirculos];

void setup() {
  size(400, 400);
  noStroke();
  smooth(8);
  
  for (int i = 0; i < numeroCirculos; i++) {
    circuloArray[i] = new circulo(100, 100);
  }
}

float a, r;

void draw() {
  background(#547980);
  translate(width/2, height/2);
  
  for(int i = 0; i < numeroCirculos; i++) {
    circuloArray[i].run(i);
    rotate(r);
    r = r + 0.00003;
  }
}
