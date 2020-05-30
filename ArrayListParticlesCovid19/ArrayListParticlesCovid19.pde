
PGraphics pg;

ArrayList<Particle> particles;
//boolean window = true;
float bl = 2;

//bl = boundarylimit
void setup() {
  frameRate(30);
  size(800, 800);

  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255);
  pg.endDraw();

  particles = new ArrayList<Particle>(100);

  while (particles.size() < 100) particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300)), pg));
}

void draw() {
  background(255);
  image(pg, 0, 0); 


  for (Particle p : particles) {

    p.run();
    p.trail();
  }



  for (Particle p1 : particles) 
    for (Particle p2 : particles) {

      if (p1.position.dist(p2.position) < 12) 


      { 
        if (!(p1.covid && p2.covid)) {
          if (p1.covid) {
            if (random(100)<20) p2.covid = true;
            else p2.exposed = true;
          }
          if (p2.covid) {

            if (random(100)<20) p1.covid = true;
            else p1.exposed = true;

            //p1.position.dist(p2.position) < 12;
          }
        }
      }
    }
}


void mousePressed() {
  Particle c = new Particle(new PVector(width/2, height/2), pg);
  c.covid = true;
  c.exposed = false;
  c.covidTime = 1;
  c.exposedTime = 0;
  particles.add(c);
}
