import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;


// Modified from:
// https://www.youtube.com/playlist?list=PLRqwX-V7Uu6akvoNKE4GAxf6ZeBYoJ4uh
// https://github.com/shiffman/Box2D-for-Processing/tree/master/Box2D-for-Processing/dist/box2d_processing/examples/box2d_exercise_solved

// Ideas:
// - Circles (see https://github.com/jbox2d/jbox2d/blob/master/jbox2d-library/src/main/java/org/jbox2d/collision/shapes/CircleShape.java).
// - Change gravity?


Box2DProcessing box2d;

// A list of all our boxes.
ArrayList<Box> boxes = new ArrayList<Box>();

// A list of all our platforms.
ArrayList<Platform> platforms = new ArrayList<Platform>();

// int framesPerSecond = 80;
int windSpeed = 0;

void setup() {
  size(800, 600);
  smooth();

  // Initialize and create the Box2D world.
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Note: x and y specify the center of the platform.
  platforms.add(new Platform(200, 400, 256, 4, 3.1));
  platforms.add(new Platform(560, 400, 256, 4, -3.1));
  platforms.add(new Platform(400, 560, 800, 4, 0));

  // frameRate(framesPerSecond);
}
// setup

void draw() {
  background(255);

  text("Box count: " + boxes.size(), width - 120, 30);
  text("Wind speed: " + windSpeed, width - 120, 60);

  PImage logoVvTP = loadImage("vvtp-logo-gray.png");
  float logoWidth = 1533 / 4;
  float logoHeight = 1404 / 4;
  image(logoVvTP, (width - logoWidth) / 2, 50, logoWidth, logoHeight);

  // We step through Box2D time whenever the draw function is called.
  box2d.step();

  // When the mouse is pressed, add a new Box object.
  if (mousePressed) {
    Box newBox = new Box(mouseX, mouseY);
    boxes.add(newBox);
  }

  if (windSpeed != 0) {
    Vec2 wind = new Vec2(windSpeed, 0);
    for (Box box : boxes) {
      box.applyForce(wind);
    }
  }

  // Display all boxes.
  for (Box box : boxes) {
    box.display();
  }

  // Display all platforms.
  for (Platform platform : platforms) {
    platform.display();
  }
}
// draw

void keyPressed() {
  // Increase wind towards the left side (key: left arrow).
  if (keyCode == LEFT) {
    windSpeed = max(-100, windSpeed - 25);
  }

  // Increase wind towards the right side (key: right arrow).
  if (keyCode == RIGHT) {
    windSpeed = min(100, windSpeed + 25);
  }

  if (key == 'c') {
    boxes.clear();
  }
}
// keyPressed
