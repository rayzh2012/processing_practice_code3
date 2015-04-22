/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/188648*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
PShape outline,details;

PVector location,velocity,target,end,fvelocity;

float r = 75;

float angle,fangle;

float xx,yy,speed,fspeed,fxmove,fymove;

float scaler = 2;

float fscaler = .001;

float red,green,blue;

void setup(){
  //size of sketch, initial bgcolor
  size(700,700);
  
  background(255);
  
  outline = loadShape("outline.svg");
  details = loadShape("details.svg");

location = new PVector(width/2,height/2);
velocity = new PVector(0,0);
target = new PVector(width/2,height/2);
end = new PVector(width/2,height/2);
fvelocity = new PVector(0,0);

    red = random(100);
    green = random(255);
    blue = random(255);
   
}

void draw(){
  
  if(keyPressed && key==' '){
    red = random(100);
    green = random(255);
    blue = random(255);
  }
  
  float eased = map(scaler,1,3,.05,.3);
  
  fscaler += (scaler - fscaler) * .1;

  
  float xmove =  (width/2) - location.x;
  float ymove =  (height/2) - location.y;
  
  
  
  fxmove += (xmove - fxmove) * eased;
  fymove += (ymove - fymove) * eased;
  
  //zoom//
  translate(width/2,height/2); // use translate around scale
  scale(fscaler);
  translate(-width/2,-height/2); // to scale from the center
  /////////
  
  
  translate(fxmove,fymove);

  
  
  velocity = PVector.sub(target,location); 

  float distance = dist(target.x,target.y,location.x,location.y);
  speed = map(distance,width,0,30,.01);
  fspeed += (speed - fspeed) * .1;
  
 // println(fspeed);
  
  velocity.limit(fspeed);
  
  if(dist(target.x,target.y,location.x,location.y)<r/2){
  fspeed = 0;
  }
  

   
  
  

  if(dist(target.x,target.y,location.x,location.y)<1){
  fvelocity.add((velocity.x-fvelocity.x)*1,(velocity.y-fvelocity.y)*1,0);
  }else{
  fvelocity.add((velocity.x-fvelocity.x)*.1,(velocity.y-fvelocity.y)*.1,0);
  }
  
 // velocity.mult(.5);
 // velocity.limit(10);
  // velocity.normalize();
 //  velocity.mult(5);
  
  if(mousePressed && mouseButton==LEFT){
    target.set(mouseX-fxmove,mouseY-fymove);
     
    
  }
  
  if(mousePressed && mouseButton==RIGHT){
      target.set(location.x,location.y);
  }
  
  PVector delta = PVector.sub(end,location);  

 // if(dist(location.x,location.y,target.x,target.y) > .1){
   angle = atan2(delta.y, delta.x);  
 // }
 
 fangle += (angle - fangle) * .01;
  
  end.set((r * cos(angle)) + location.x,(r * sin(angle)) + location.y);
  

  
 



location.add(fvelocity);
  


  
background(125);
  
  


  
  stroke(115);
strokeWeight(3);
for(int i = -width*10; i < width*10; i += 100){
 line(-width*10,i,width*10,i);
 line(i,-width*10,i,height*10);
}



  
   xx = (location.x+end.x)/2;
   yy = (location.y+end.y)/2;
  
//line(location.x,location.y,end.x,end.y);
//line(xx,yy,end.x,end.y);
translate(end.x,end.y);
rotate(angle);
strokeWeight(25);
//line(-75,0,0,0);

rotate(radians(90));

 outline.disableStyle();

fill(red,green,blue);
noStroke();
shape(outline, -20, 0);
shape(details, -20, 0);



  
}

void mouseScrolled()
{
   if(mouseScroll > 0)
   {
       scaler-=.2;
   }
   else
   {
      scaler+=.2;
   }
   
    if(scaler >= 3){
  scaler = 3;
  }
  
  if(scaler <= 1){
    scaler = 1;
  }

}


/*void mouseWheel(MouseEvent event) {
  
  float e = event.getCount();
  
  scaler-=(e/5);
  
  if(scaler >= 3){
  scaler = 3;
  }
  
  if(scaler <= 1){
    scaler = 1;
  }
  
  
}
*/

