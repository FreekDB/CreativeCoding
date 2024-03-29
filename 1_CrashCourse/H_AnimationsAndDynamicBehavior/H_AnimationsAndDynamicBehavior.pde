// Creative Coding workshop: Animations and Dynamic Behavior.
// Adaptation of the Bouncing Balls example on Happy Coding.
// The circles move slower when they get close to the mouse cursor.
// Left click increases the frame rate and right click decreases.
// Link: https://happycoding.io/examples/processing/arrays/bouncing-balls
// Freek de Bruijn.
// April, 2021.

int ballCount = 28;

float[] x = new float[ballCount];
float[] y = new float[ballCount];
float[] xSpeed = new float[ballCount];
float[] ySpeed = new float[ballCount];
float[] size = new float[ballCount];
float[] redPart = new float[ballCount];
float[] greenPart = new float[ballCount];
float[] bluePart = new float[ballCount];

int currentFrameRate = 40;

// Setup with one-time initialization.
// (This function is called by Processing when it starts the program.)
void setup() {
  // Set the size of our artwork (width, height in pixels).
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Animations and Dynamic Behavior from Happy Coding");

  for(int ballIndex = 0; ballIndex < ballCount; ballIndex++) {
    // Pick a random start position for this ball.
    x[ballIndex] = random(width);
    y[ballIndex] = random(height);

    // Pick a random speed for this ball.
    xSpeed[ballIndex] = random(-5, 5);
    ySpeed[ballIndex] = random(-5, 5);

    // Pick a random size for this ball.
    size[ballIndex] = random(10, 64);

    // Pick a random color for this ball.
    redPart[ballIndex] = random(256);
    greenPart[ballIndex] = random(256);
    bluePart[ballIndex] = random(256);
  }

  // Set the frame rate: the number of times draw is called per second.
  frameRate(currentFrameRate);
}

// Code to move and draw the bouncing balls.
void draw() {
  background(200);

  for (int ballIndex = 0; ballIndex < ballCount; ballIndex++) {
    // Calculate distance to mouse.
    float distanceToMouse = abs(x[ballIndex] - mouseX) + abs(y[ballIndex] - mouseY);
    // The speed is proportional to the distance to the mouse.
    float speedFactor = distanceToMouse / (width + height);

    // Change the x coordinate for this ball.
    x[ballIndex] = x[ballIndex] + speedFactor * xSpeed[ballIndex];

    // Change the direction for this ball by reversing the sign of the x speed.
    if (x[ballIndex] < 0 || x[ballIndex] > width) {
      xSpeed[ballIndex] = -xSpeed[ballIndex];
    }

    // Change the y coordinate for this ball.
    y[ballIndex] = y[ballIndex] + speedFactor * ySpeed[ballIndex];

    // Change the direction for this ball by reversing the sign of the y speed.
    if (y[ballIndex] < 0 || y[ballIndex] > height) {
      ySpeed[ballIndex] = -ySpeed[ballIndex];
    }

    // Set the fill color for this ball.
    fill(redPart[ballIndex], greenPart[ballIndex], bluePart[ballIndex]);

    // Draw a circle with the right coordinates and size for this ball.
    circle(x[ballIndex], y[ballIndex], size[ballIndex]);
  }

  fill(0);
  text("Frame rate: " + currentFrameRate, 20, 28);
}

// Click the left mouse button: increase the frame rate.
// Click the right mouse button: decrease the frame rate.
void mouseClicked() {
  if (mouseButton == LEFT) {
    currentFrameRate = currentFrameRate + 10;
  } else {
    if (currentFrameRate >= 20) {
      currentFrameRate = currentFrameRate - 10;
    } else {
      currentFrameRate = max(currentFrameRate - 1, 1);
    }
  }

  frameRate(currentFrameRate);
}
