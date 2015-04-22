/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/191170*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
float my_num=0;
void setup(){
  size(650,650);
  frameRate(35);
}
void draw(){
  float r=2;
  background(255);
  translate(width/2,height/2);
  while(r<400){
    rotate(r);
    stroke(0);
    strokeWeight(0.6);
    
    //center black solid
    fill(0,10);
    ellipse(0,0,r*noise(my_num)-30,r*noise(my_num)-30);
    
    
    noFill();
    ellipse(r*noise(my_num),50,r*noise(my_num),200);
    
    //blue lines
    stroke(50,random(100,140),random(100,140));
    line(r*noise(my_num),50,r*noise(my_num),150);
    
    //grey outer lines
    stroke(230);
    ellipse(r*noise(my_num),r*noise(my_num)+300,r*noise(my_num),150);
    r=r+0.1;
  }
  
  my_num=my_num+0.09;
}

