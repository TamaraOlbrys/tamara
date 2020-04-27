// where do you i update distance once infected or exposed
//pGraphics
//movment 

//

ArrayList<Particle> particles;
boolean window = true;
float bl =25;

//bl = boundarylimit
void setup() {
  frameRate(30);
  size(800, 800);
  particles = new ArrayList<Particle>(100);

  while (particles.size() < 100) particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));
}

void draw() {
  background(255);

if (window) {
    stroke(175);
    noFill();
    rectMode(CENTER);
    rect(width/2, height/2, width-bl*2, height-bl*2);
  }
  //z pewnym prawdopodobienstwem dodaje nowy na koncu listy
  //if (random(100) < 10) 
  //particles.add(new Particle(new PVector(random(300, width-300), random(300, height-300))));

  //usuwa martwa z poczatku listy
  //if (particles.get(0).isDead()) particles.remove(0);
  //ile mamy na licie
  //if (frameCount%100 == 0) println(particles.size());


 for (Particle p : particles) {
    p.boundaries();
  }
  
  
  for (Particle p : particles) {
    p.run();
  }
  
 


  for (Particle p1 : particles) 
    for (Particle p2 : particles) {

      if (p1.position.dist(p2.position) < 12) 


      { 
        if (!(p1.covid && p2.covid)) {
          if (p1.covid) {
            if (random(100)<70) p2.covid = true;
            else p2.exposed = true;
          }
          if (p2.covid) {

            if (random(100)<70) p1.covid = true;
            else p1.exposed = true;
            
            //p1.position.dist(p2.position) < 12;
          }
          
         
        }
        
      
        
        
      }


      if (!(p1.exposed && p2.exposed)) {
        if (p1.exposed) {
          if (random(100)<25) p2.exposed = true;
          else p2.covid = true;
        }
        if (p2.exposed) {

          if (random(100)<25) p1.exposed = true;
          else p1.covid = true;
        }
      }
    }
}






void mousePressed() {
  Particle c = new Particle(new PVector(width/2, height/2));
  c.covid = true;
  c.exposed = false;
  c.covidTime = 1;
  c.exposedTime = 0;
  particles.add(c);
}
