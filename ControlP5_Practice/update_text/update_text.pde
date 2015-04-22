int [] angle= new int[2];

void setup() {
textSize(32);
//text("word", 10, 30); 
//fill(0, 102, 153);
//text("word", 10, 60);
//fill(0, 102, 153, 51);
//text("word", 10, 90); 
frameRate(1);
}

void  random_num(int[] angle) {
  
  //for (int i = 0; i < 100; i++) {
  int r = int(random(360));
  angle[0] = r;
  angle[1] = 360-r;
  println(angle);
  //stroke(r*5);
 // line(50, i, 50+r, i);
//return angle;
//}

}




void draw()
{
 background(0); // For a black background.
  fill(0, 102, 153);
  random_num(angle);
  text(angle[0], 10, 90); 
    stroke(0);
   //rect(50,80,textWidth("aaaa"),20);// erase text
 
  //setup();
}
