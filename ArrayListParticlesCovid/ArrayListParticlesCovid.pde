ArrayList<Particle> particles;

void setup() {
  size(800, 800);
  particles = new ArrayList<Particle>();

  Particle c = new Particle(new PVector(width/2, height/2));
  c.covid = true;
  particles.add(c);
}

void draw() {
  background(255);

  if (random(100) < 10) 
    particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));

  for (Particle p : particles) {
    p.run();
  }

  for (Particle p1 : particles) 
    for (Particle p2 : particles) {
      if (p1.position.dist(p2.position) < 12) { 
        if (p1.covid)  p2.covid = p1.covid; 
        else if (p2.covid)   p1.covid = p2.covid;
      }
    }
}
