/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/188350*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/* @pjs preload="user3.png,menu.png,news.png,weather.png,stats.png,movie.png,background.png"; */
int myState = 0 ; 
PImage background ;
PImage user ;
PImage menu ;
PImage news ;
PImage music ;
PImage weather ;
PImage stats ;
PImage movie ;

void setup() {
  size(500, 500) ;
  user = loadImage("user3.png") ;
  menu = loadImage("menu.png") ;
  news = loadImage("news.png") ;
  music = loadImage ("music.png") ;
  weather = loadImage ("weather.png") ;
  stats = loadImage ("stats.png") ;
  movie = loadImage ("movie.png") ;
  background = loadImage("background.png") ;
}


void draw() {

  switch(myState) {
  case 2: 
    image(background, 0, 0, width, height) ; 
    image(user, -395, 35, 1600, 1000) ;
    image(menu, -233, 120, 1200, 1200) ;
    image(music, -258, 140, 800, 700) ;
    image(weather, 107, 130, 800, 700) ;
    image(stats, -323, -120, 1400, 800) ;
    break ;

  case 3: 
    image(background, 0, 0, width, height) ;
    image(menu, -233, 110, 1200, 1200) ;
    image(user, -130, 415, 400, 200) ; 
    image(music, -535, 40, 1600, 1000) ;
    image(movie, 0, 125, 900, 700) ;
    image(stats, -323, -120, 1400, 800) ;

    break ;

  case 4: 
    image(background, 0, 0, width, height) ;
    image(menu, -233, 110, 1200, 1200) ;
    image(weather, 107, -90, 800, 700) ;
    image(stats, -323, 100, 1400, 800) ;
    image(user, -130, 415, 400, 200) ;
    image(music, -675, -147, 2100, 900) ;
    image(movie, 332, 415, 300, 200) ;
    break ;

  case 5: 
    image(background, 0, 0, width, height) ;
    image(menu, -233, 110, 1200, 1200) ;
    image(movie, 332, 415, 300, 200) ;
    image(user, -130, 415, 400, 200) ;
    image(weather, 40, 65, 900, 900) ;
    image(music, -690, 60, 2100, 900) ;
    image(stats, -365, -100, 1500, 700) ;
    break ;

  case 1: 
    image(background, 0, 0, width, height) ;
    image(menu, -233, 115, 1200, 1200) ;
    image(weather, 40, 65, 900, 900) ;
    image(user, -130, 415, 400, 200) ;
    image(movie, -275, 100, 1100, 750) ;
    image(stats, -323, -97, 1400, 700) ;
    image(music, 303, 418, 400, 200) ;
    break ;
  }
}

void mousePressed() {
  myState = myState + 1 ;
  if (myState > 6) {
    myState = 0 ;
  }
}

