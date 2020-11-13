// Creative Coding workshop: Circles and Ellipses.
// Adaptation of Random Circles example on Happy Coding. 
// Link: https://happycoding.io/examples/processing/for-loops/random-circles
// Freek de Bruijn.
// November, 2020.

// Setup with one-time initialization. (This function is called by Processing when it starts the program.)
void setup() {
  // Set the size of our artwork (width, height in pixels).
  size(800, 600); 
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Circles and Ellipses from Happy Coding");

  background(64);
  noStroke();
  frameRate(2);
}

// Draw instructions to add another stack of circles to the screen.
void draw() {
  float circleSize = random(25, 100);

  float x = random(width);
  float y = random(height);

  for (float ringSize = circleSize; ringSize >= 0; ringSize -= random(2, 10)) {
    fill(random(256), random(256), random(256));
    // circle(x, y, ringSize);
    ellipse(x, y, 1.1 * ringSize, ringSize);
  }
}
