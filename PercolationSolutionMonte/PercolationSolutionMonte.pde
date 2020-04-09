// Wieslaw Bartkowski
// Dla Tamary 2020

GOL gol;

void setup() {
  size(1000, 1000);
  frameRate(5);
  gol = new GOL();
}

void draw() {
  background(255);

  gol.generate();
  gol.display();
}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}
