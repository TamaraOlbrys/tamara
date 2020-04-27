/*
* WB dla Tamara
* 2020 Creative Coding
*/


PGraphics pg;

float x1 = 250;
float y1 = 250;
float x2 = 250;
float y2 = 250;
float x3 = 250;
float y3 = 250;

void setup() {
  size(500, 500);
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255);
  pg.endDraw();
}

void draw() {

  pg.beginDraw();
  pg.stroke(0, 20);
  pg.strokeWeight(7);
  //tylko pierwszy zostawia slad
  pg.point(x1, y1);
  pg.endDraw();
  //w pg pamietany jest slad
  image(pg, 0, 0);
  
  
  strokeWeight(15);
  stroke(200,100,100);
  point(x1,y1);
  stroke(0);
  point(x2,y2);
  point(x3,y3);
  
  x1 += random(-5,5);
  y1 += random(-5,5);
  x2 += random(-5,5);
  y2 += random(-5,5);
  x3 += random(-5,5);
  y3 += random(-5,5);
}
