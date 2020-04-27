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

  int covidTime;
  int exposedTime;
  boolean isDead;

  float maxspeed;
  float maxforce;

  Particle(PVector l) {
    acceleration = new PVector(random(-0.15, 0.15), random(-0.15, 0.15));
    velocity = new PVector(0, 0);
    velocity.mult(5);
    position = l.copy();

    maxspeed = 3;
    maxforce = 0.15;

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

      if (exposedTime>300) { 
        //exposedTime=0; 
        exposed = false;
      }
    }
  }


  void updateCovidTime() {
    if (covid) covidTime++; 
    if (covidTime>250) { 
      if (random(100)<80) {
        //covidTime = 0; 
        covid = false;
        exposed = true && exposedTime > 250;
        //else isDead = true;
      }
    }
  }

  void run() {
    update();
    
    display();
    
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    //if (position.x < 0 || position.x > width) velocity.x = -velocity.x;  
    //if (position.y < 0 || position.y > height) velocity.y = -velocity.y;  
    //zarazony szybciej sie starzeje


    if (covid) lifespan -= lifeDecline*2;
    else lifespan -= lifeDecline;
    //martwy nie zaraza
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
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  // Method to display
  void display() {
    stroke(0);
    strokeWeight(2);
    if (exposed)
      fill(#0C8FF0, lifespan);

    else if (covid) 
      fill(255, 0, 0, lifespan);
    else if (isDead)
      fill(0, 255, 0, lifespan);
    else
      fill(127, lifespan);

    ellipse(position.x, position.y, 12, 12);
  }





  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
