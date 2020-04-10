/*
* Wieslaw 2020 dla Tamara
* Creative Codin
*
* On mouse pressed it is adding new active covid to the World 
*/

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

  //z pewnym prawdopodobienstwem dodaje nowy na koncu listy
  if (random(100) < 10) 
    particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));
  
  //usuwa martwa z poczatku listy
  if (particles.get(0).isDead()) particles.remove(0);
  //ile mamy na licie
  if (frameCount%100 == 0) println(particles.size());

  for (Particle p : particles) {
    p.run();
  }

  for (Particle p1 : particles) 
    for (Particle p2 : particles) {
      if (p1.position.dist(p2.position) < 12) { 
        if (p1.covid) p2.covid = p1.covid; 
        else if (p2.covid) p1.covid = p2.covid;
      }
    }
}

void mousePressed() {
  Particle c = new Particle(new PVector(width/2, height/2));
  c.covid = true;
  particles.add(c);
}
