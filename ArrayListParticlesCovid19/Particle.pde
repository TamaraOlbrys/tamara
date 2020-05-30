// if acceleration changes due to lifespan - how to define lifespan?
// lifeDecline only need for isDead - if a closed systems - not all die and are removed

// avoidance has to be defined as a function in both updateExposed and CovidTime

class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;


  PGraphics paint;

  boolean covid;
  boolean exposed;

  float covidTime;
  float exposedTime;
  boolean isDead;

  float maxspeed;
  float maxforce;


  float hyperactivity;
  float changeDirection;


  float r;

  Particle(PVector l, PGraphics pg) {
    acceleration = new PVector(random(-0.15, 0.15), random(-0.15, 0.15));
    velocity = new PVector(random(-1, 1), random(-1, 1));
    velocity.mult(5);
    position = l.copy();

    paint = pg;

    maxspeed = random(3, 5);
    maxforce = 0.15;
    hyperactivity = random(0, 100);
    //changeDirection = random(0,100);

    r = 15;

    covid = false;
    exposed = false;
    isDead = false;

    covidTime = 0;
    exposedTime = 0;
  }

  void run() {
    update();
    boundaries();
    updateCovidTime();
    updateExposedTime();
    applyAvoid(particles);
    changeDirection();

    display();
  }

  void update() {
     if (isDead) {
        velocity.x = 0;
        velocity.y = 0;
      } else
      {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
      }
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

      if (random(100)<10) {
        covidTime = 0; 
        covid = false;
        isDead = true;
      }

     
    }
  }


  void changeDirection() {

    if (hyperactivity > 50 ) acceleration.rotate(random(-PI/4, PI/4));


    if (covid) {
      if (hyperactivity>15) {
        acceleration.rotate(random(-PI/3, PI/3));
      }
    }
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
      desired = new PVector(velocity.x, -maxspeed*0.5);
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

    separateForce.mult(5);

    applyForce(separateForce);
  }

  PVector separate (ArrayList<Particle> particles) {
    float desiredseparation = r;
    float desiredseparationCovid = 50;
    float desiredseparationExposed = 30;

    PVector sum = new PVector();


    for (Particle other : particles) {
      float d = PVector.dist(position, other.position);

      if ((d > 0) && (d < desiredseparation)) {

        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        
        sum.add(diff);
      }


      if (covid) { 
        if (covidTime > 10) {


          if ((d > 0) && (d < desiredseparationCovid)) {

            PVector diff = PVector.sub(position, other.position);
            diff.normalize();
            diff.div(d);        
            sum.add(diff);
          }
        }
      }


      if (exposed) { 
        if (exposedTime > 20) {


          if ((d > 0) && (d < desiredseparationExposed)) {

            PVector diff = PVector.sub(position, other.position);
            diff.normalize();
            diff.div(d);        
            sum.add(diff);
          }
        }
      }
    }


    return sum;
  }


  void display() {
    stroke(0);
    strokeWeight(2);
    if (isDead)
      fill(0,255,0);

    else if (covid) 
      fill(255, 0, 0);
    else if (exposed)
      fill(#0C8FF0);
    else
      fill(127);

    ellipse(position.x, position.y, 12, 12);
  }



  void trail() {
    if (covid) { 
      paint.beginDraw();
      paint.stroke(255, 0, 0, 10);
      paint.strokeWeight(7);
      //tylko pierwszy zostawia slad
      paint.point(position.x, position.y);
      paint.endDraw();
    }

    if (exposed) {
      paint.beginDraw();
      paint.stroke(#0C8FF0, 10);
      paint.strokeWeight(5);
      //tylko pierwszy zostawia slad
      paint.point(position.x, position.y);
      paint.endDraw();
    }
  }
}
