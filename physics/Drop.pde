class Drop {

  float x = random(width);
  float y = random(-200, -100);
  float yspeed = random(1, 5);
  float length = random(10, 20);
  
  void fall() {
    y = y + yspeed;
    yspeed = yspeed + 0.05;
    
    if(y > height) {
      y = random(-200, -100);
      yspeed = random(1, 5);
    }
  }
  
  void show() {
    noStroke();
    fill(random(255), random(255), random(255));
    ellipse(x, y + length, 20, 20);
  }
  
  void small() {
    noStroke();
    fill(random(255), random(255), random(255));
    ellipse(x, y + length, 5, 5);
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
}