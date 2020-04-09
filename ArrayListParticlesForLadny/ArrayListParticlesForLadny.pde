ArrayList<Particle> particles;

void setup() {
  size(800, 800);
  particles = new ArrayList<Particle>();
}

void draw() {
  background(255);

  particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));

  // Looping through backwards to delete
  for (Particle p: particles) {
    p.run();
  }
}
