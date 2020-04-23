/*
* Wieslaw 2020 dla Tamara
 * Creative Codin
 *
 * On mouse pressed it is adding new active covid to the World 
 */

ArrayList<Particle> particles;

void setup() {
  frameRate(30);
  size(800, 800);
  particles = new ArrayList<Particle>(100);

  while (particles.size() < 100) particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));
  
 
  
}

void draw() {
  background(255);

  //z pewnym prawdopodobienstwem dodaje nowy na koncu listy
  //if (random(100) < 10) 
  //particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));

  //usuwa martwa z poczatku listy
  if (particles.get(0).isDead()) particles.remove(0);
  //ile mamy na licie
  if (frameCount%100 == 0) println(particles.size());

  for (Particle p : particles) {
    p.run();
  }


  for (Particle p1 : particles) 
    for (Particle p2 : particles) {

      if (p1.position.dist(p2.position) < 12) 


      { 
        if (!(p1.covid && p2.covid)) {
          if (p1.covid) {
            if (random(100)<10) p2.covid = true;
            else p2.exposed = true;
          }
          if (p2.covid) {

            if (random(100)<10) p1.covid = true;
            else p1.exposed = true;
          }
        }
      }
    }



      for (Particle p1 : particles)
        for (Particle p2 : particles)
        {
          p1.updateCovidTime();
          p1.updateExposedTime();
          p2.updateCovidTime();
          p2.updateExposedTime();
        }
    }

  void mousePressed() {
    Particle c = new Particle(new PVector(width/2, height/2));
    c.covid = true;
    c.exposed = false;
    c.covidTime = 3;
    c.exposedTime = 0;
    particles.add(c);
  }
