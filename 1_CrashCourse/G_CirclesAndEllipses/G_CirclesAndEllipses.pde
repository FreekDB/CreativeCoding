// Creative Coding workshop: Circles and Ellipses.
// Adaptation of Random Circles example on Happy Coding.
// Link: https://happycoding.io/examples/processing/for-loops/random-circles
// Freek de Bruijn.
// April, 2021.

// Setup with one-time initialization.
void setup() {
  // Set the size of our artwork (width, height in pixels).
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Circles and Ellipses from Happy Coding");

  background(64);
  noStroke();
  frameRate(2);
}

// Draw instructions to add yet another stack of circles to the screen.
void draw() {
  // Pick a random size for the stack of circles.
  float circleSize = random(25, 100);

  // Pick a random position on the screen.
  float x = random(width);
  float y = random(height);

  for (float ringSize = circleSize; ringSize >= 0; ringSize -= random(2, 10)) {
    // Pick a random color to fill the next circle.
    fill(random(256), random(256), random(256));

    // Add the next circle/ellipse to the stack.
    // circle(x, y, ringSize);
    ellipse(x, y, 1.1 * ringSize, ringSize);
  }
}
