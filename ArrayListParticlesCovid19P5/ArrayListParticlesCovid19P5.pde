/*
* Wieslaw 2020 dla Tamara
* Creative Codin
*
* On mouse pressed it is adding new active covid to the World 
*/

import controlP5.*;

ControlP5 cp5;

int sliderValue = 100;

Slider abc;

ArrayList<Particle> particles;

void setup() {
  size(800, 800);
  particles = new ArrayList<Particle>();

  cp5 = new ControlP5(this);
  
    cp5.addSlider("sliderValue")
     .setPosition(50,50)
     .setSize(200,20)
     .setCaptionLabel("Life decline rate for infected")
     .setColorValue(color(255,255,255)) //kolor wartosci
     .setColorLabel(color(0,0,0)) //kolor etykiery
     .setRange(1, 20) //zakres
     .setValue(7) //wartosc poczatkowa
     ;

  Particle c = new Particle(new PVector(width/2, height/2));
  c.covid = true;
  particles.add(c);
}

void draw() {
  background(255);

  //z pewnym prawdopodobienstwem dodaje nowy na koncu listy
  if (random(100) < 30) 
    particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));
  
  //usuwa martwa z poczatku listy
  if (particles.get(0).isDead()) particles.remove(0);
  //ile mamy na licie
  if (frameCount%100 == 0) println(particles.size());

  for (Particle p : particles) {
    p.run();
    p.updateDeclineInfested(sliderValue);
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
