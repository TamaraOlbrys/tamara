// The Nature of Code
// Daniel Shiffman
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

  Particle(PVector l) {
    acceleration = new PVector(random(-0.15, 0.15), random(-0.15, 0.15));
    velocity = new PVector(0, 0);
    position = l.copy();

    covid = false;
    exposed = false;

    covidTime = 0;
    exposedTime = 0;
    //max dlugosc rzycia
    lifespan = 255;
    //jak szybko sie ztarzeje

    lifeDecline = random(0.01,0.1);
  }


  void updateExposedTime() {
    if (exposed) exposedTime++; 
    if (exposedTime>70)  { 
      //exposedTime=0; 
      exposed = false;
      
      
    }
  }


  void updateCovidTime() {
    if (covid) covidTime++; 
    if (covidTime>50) { 
      //covidTime = 0; 
      covid = false;
    }
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    if (position.x < 0 || position.x > width) velocity.x = -velocity.x;  
    if (position.y < 0 || position.y > height) velocity.y = -velocity.y;  
    //zarazony szybciej sie starzeje
    
    
    if (covid) lifespan -= lifeDecline*2;
    else lifespan -= lifeDecline;
    //martwy nie zaraza
    
    
    //if (isDead()) covid = false;
  }


  // Method to display
  void display() {
    stroke(0);
    strokeWeight(2);
    if (exposed)
      fill(#0C8FF0,lifespan);

    else if (covid) 
      fill(255, 0, 0,lifespan);
    else
      fill(127,lifespan);
    ellipse(position.x, position.y, 12, 12);
  }





  // Is the particle still useful?
  boolean isDead() {
    return (lifespan < 0.0);
  }
}
