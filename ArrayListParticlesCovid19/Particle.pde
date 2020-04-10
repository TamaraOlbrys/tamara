// The Nature of Code
// Daniel Shiffman
class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  float lifeDecline;
  boolean covid;

  Particle(PVector l) {
    acceleration = new PVector(random(-0.15, 0.15), random(-0.15, 0.15));
    velocity = new PVector(0, 0);
    position = l.copy();
    lifespan = 255.0;
    lifeDecline = random(0.1, 1.0);
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
    if(covid) lifespan -= lifeDecline*5 ;else lifespan -= lifeDecline;
    if (isDead()) covid = false;
  }

  // Method to display
  void display() {
    stroke(0, lifespan);
    strokeWeight(2);
    if (covid) 
      fill(255, 0, 0, lifespan);
    else
      fill(127, lifespan);
    ellipse(position.x, position.y, 12, 12);
  }

  // Is the particle still useful?
  boolean isDead() {

    return (lifespan < 0.0);
  }
}
