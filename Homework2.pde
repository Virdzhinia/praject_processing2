int numFlowers = 7;
int numStars = 30;
Flower[] flowers = new Flower[numFlowers];
Star[] stars = new Star[numStars];
int frameCountToSave = 5;

void setup() {
  size(800, 800);
  for (int i = 0; i < numFlowers; i++) {
    flowers[i] = new Flower(random(width), random(height), random(50, 100));
  }
  for (int i = 0; i < numStars; i++) {
    stars[i] = new Star(random(width), random(-height, 0), random(2, 5));
  }
  noStroke();
}

void draw() {
  background(30, 30, 60, 50); 
  for (int i = 0; i < numFlowers; i++) {
    flowers[i].move();
    flowers[i].display();
  }
  for (int i = 0; i < numStars; i++) {
    stars[i].move();
    stars[i].display();
  }
  
  // Save frames
  if (frameCount <= frameCountToSave) {
    saveFrame("output/frame-####.png");
  }
}

class Flower {
  float x, y;
  float baseX, baseY;
  float size;
  float angle;
  float noiseOffsetX, noiseOffsetY;
  color c;

  Flower(float tempX, float tempY, float tempSize) {
    baseX = tempX;
    baseY = tempY;
    size = tempSize;
    angle = random(TWO_PI);
    noiseOffsetX = random(10);
    noiseOffsetY = random(10);
    c = color(random(150, 255), random(150, 255), random(150, 255));
  }

  void move() {
    noiseOffsetX += 0.01;
    noiseOffsetY += 0.01;
    x = baseX + map(noise(noiseOffsetX), 0, 1, -50, 50);
    y = baseY + map(noise(noiseOffsetY), 0, 1, -50, 50);
  }

  void display() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    for (int i = 0; i < 10; i++) {
      float petalSize = size + sin(angle + i * TWO_PI / 10) * size * 0.5;
      fill(c, 150);
      ellipse(cos(i * TWO_PI / 10) * size, sin(i * TWO_PI / 10) * size, petalSize, petalSize);
    }
    popMatrix();
    angle += 0.01;
    size = map(noise(noiseOffsetX), 0, 1, 50, 100); 
  }
}

class Star {
  float x, y;
  float baseX, baseY;
  float speed;
  float noiseOffset;
  color c;

  Star(float tempX, float tempY, float tempSpeed) {
    baseX = tempX;
    baseY = tempY;
    speed = tempSpeed;
    noiseOffset = random(10);
    c = color(255, 255, random(150, 255), 200);
  }

  void move() {
    noiseOffset += 0.01;
    y = baseY + map(noise(noiseOffset), 0, 1, -10, 10);
    baseY += speed;
    if (baseY > height) {
      baseY = random(-height, 0);
      baseX = random(width);
    }
    x = baseX + map(noise(noiseOffset + 5), 0, 1, -10, 10); 
  }

  void display() {
    fill(c);
    ellipse(x, y, 3, 3);
  }
}
