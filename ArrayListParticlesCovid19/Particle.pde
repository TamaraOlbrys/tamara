// if acceleration changes due to lifespan - how to define lifespan?
// lifeDecline only need for isDead - if a closed systems - not all die and are removed

// avoidance has to be defined as a function in both updateExposed and CovidTime

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float lifeDecline;

  boolean covid;
  boolean exposed;

  float covidTime;
  float exposedTime;
  boolean isDead;

  float maxspeed;
  float maxforce;

  float r;

  Particle(PVector l) {
    acceleration = new PVector(random(-0.15, 0.15), random(-0.15, 0.15));
    velocity = new PVector(0, 0);
    velocity.mult(5);
    position = l.copy();

    maxspeed = 3;
    maxforce = 0.15;

    r = 10;

    covid = false;
    exposed = false;
    isDead = false;

    covidTime = 0;
    exposedTime = 0;

    //max dlugosc rzycia
    lifespan = 255;
    //jak szybko sie ztarzeje

    lifeDecline = random(0.01, 0.1);
  }


  void updateExposedTime() {
    if (exposed) exposedTime++;
    {

      if (exposedTime>250) { 
        exposedTime=0; 
        exposed = false;
      }
    }
  }


  void updateCovidTime() {
    if (covid) covidTime++; 
    if (covidTime>250) { 
      if (random(100)<80) {
        covidTime = 0; 
        covid = false;
      }
    }
  }

  void run() {
    update();

    display();
  }


  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);


    updateCovidTime();
    updateExposedTime();


    //if (isDead()) covid = false;
  }


  void boundaries() {

    PVector desired = null;

    if (position.x < bl) {
      desired = new PVector(maxspeed*0.5, velocity.y);
    } else if (position.x > width - bl) {
      desired = new PVector(-maxspeed*0.5, velocity.y);
    } 

    if (position.y < bl) {
      desired = new PVector(velocity.x, maxspeed*0.5);
    } else if (position.y > height - bl) {
      desired = new PVector(velocity .x, -maxspeed*0.5);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }  

  void applyForce(PVector force) {

    acceleration.add(force);
  }

  void applyAvoid(ArrayList<Particle> particles) {
    PVector separateForce = separate(particles);

    separateForce.mult(10);

    applyForce(separateForce);
  }

  PVector separate (ArrayList<Particle> particles) {
    float desiredseparation = r*20;
    PVector sum = new PVector();


    for (Particle other : particles) {
      float d = PVector.dist(position, other.position);


      if (covid) { 
        if (covidTime > 10) {
          if (exposed) {
            if (exposedTime > 20) {

              if ((d > 0) && (d < desiredseparation)) {
                
                PVector diff = PVector.sub(position, other.position);
                diff.normalize();
                diff.div(d);        
                sum.add(diff);
              }
            }
          }
        }
      }
    }
    return sum;
  }


  void display() {
    stroke(0);
    strokeWeight(2);
    if (exposed)
      fill(#0C8FF0);

    else if (covid) 
      fill(255, 0, 0);
    else if (isDead)
      fill(0, 255, 0);
    else
      fill(127);

    ellipse(position.x, position.y, 12, 12);
  }
}
