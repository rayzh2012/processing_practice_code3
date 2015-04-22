abstract class Node {
  Node [] children;
  PMatrix2D trf = new PMatrix2D(); 
  
  abstract void draw(PGraphics b, PGraphics g);
}
