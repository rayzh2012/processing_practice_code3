boolean animate = false;

void keyPressed ()
{ 
  if (keyCode == KeyEvent.VK_SPACE) vis.displayMode();
  if (keyCode == KeyEvent.VK_RIGHT) vis.measureUp();
  if (keyCode == KeyEvent.VK_LEFT) vis.measureDown();
  if (keyCode == KeyEvent.VK_H) vis.toggleHeadline();
  if (keyCode == KeyEvent.VK_S) vis.toggleAnimationMode();
  if (keyCode == KeyEvent.VK_A)
  {
    animate = !animate;
    vis = new Buergschaft (new TextAnalyzer (txtSource, txtInputType, animate), txtTitle);
  }
  /*
  if (keyCode == KeyEvent.VK_M) {
    saveMov = !saveMov;
    if (saveMov) {
      mm = new MovieMaker(this, width, height, "export/" + timestamp() + "_data.mov", 30, MovieMaker.ANIMATION, MovieMaker.HIGH);
      vis = new Buergschaft (new TextAnalyzer (txtSource, txtInputType, animate), txtTitle);
    }
  }
  
  if (keyCode == KeyEvent.VK_E)
  {
    if (saveMov) mm.finish();
    saveMov = false;
  }
   if (keyCode == KeyEvent.VK_P) savePDF = !savePDF;
   if (keyCode == KeyEvent.VK_O) saveFrame ( "export/" + timestamp() + ".png");
   */
}

