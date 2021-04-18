// Creative Coding workshop: Lines and Points.
// Freek de Bruijn.
// April, 2021.

// https://en.wikipedia.org/wiki/Clock_face

import java.util.Collections;
import java.util.List;
import java.util.Random;

color backgroundColor = color(100, 150, 200);
color normalStrokeColor = color(255);

// Initialization.
void setup() {
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Lines and Points");
  stroke(normalStrokeColor);

  // generateCirclePointsInitializationCode();
}

PVector center = new PVector(300, 300);
int radius = 200;

int visibleItemCount = 1;
int totalItemCount = 15;

// Draw a frame.
void draw() {
  background(backgroundColor);

  strokeWeight(6);
  point(center.x, center.y);

  // Circle points in random order.
  PVector[] circlePoints = {
    new PVector(199.0, 473.0),
    new PVector(500.0, 300.0),
    new PVector(100.0, 299.0),
    new PVector(399.0, 473.0),
    new PVector(299.0, 500.0),
    new PVector(199.0, 126.0),
    new PVector(126.0, 399.0),
    // new PVector(500.0, 300.0),
    new PVector(473.0, 200.0),
    new PVector(126.0, 199.0),
    new PVector(300.0, 100.0),
    new PVector(473.0, 400.0),
    new PVector(400.0, 126.0)
  };

  int visiblePoints = min(circlePoints.length, visibleItemCount - 1);
  for (int circlePointIndex = 0; circlePointIndex < visiblePoints; circlePointIndex++) {
    point(circlePoints[circlePointIndex].x, circlePoints[circlePointIndex].y);
  }

  // Minute hand. Time 14:40 => 210 degrees.
  if (visibleItemCount >= circlePoints.length + 2) {
    strokeWeight(3);
    PVector minutesEndPoint = pointOnCircle(center, radius, 210.0 / 360.0 * TWO_PI);
    line(center.x, center.y, minutesEndPoint.x, minutesEndPoint.y);
  }

  // Hour hand. Time 14:40 => 30 degrees.
  if (visibleItemCount >= circlePoints.length + 3) {
    strokeWeight(6);
    PVector hoursEndPoint = pointOnCircle(center, 0.7 * radius, 10.0 / 360.0 * TWO_PI);
    line(center.x, center.y, hoursEndPoint.x, hoursEndPoint.y);
  }
}

// Click the left mouse button: increase the visible item count or reset to one.
// Click the right mouse button: go back.
void mouseClicked() {
  if (mouseButton == LEFT) {
    visibleItemCount = visibleItemCount + 1;

    if (visibleItemCount > totalItemCount) {
      visibleItemCount = 1;
    }
  } else {
    visibleItemCount = max(1, visibleItemCount - 1);
  }
}

PVector pointOnCircle(PVector center, float radius, float angleRadians) {
  int x = int(center.x + radius * cos(angleRadians));
  int y = int(center.y - radius * sin(angleRadians));

  return new PVector(x, y);
}

// Generate the initialization of the circle points array for this program.
// void generateCirclePointsInitializationCode() {
//   List<String> lines = new ArrayList<String>();
//
//   float stepRadians = TWO_PI / 12.0;
//
//   for (float angleRadians = 0.0; angleRadians < TWO_PI; angleRadians += stepRadians) {
//     PVector circlePoint = pointOnCircle(center, radius, angleRadians);
//
//     lines.add("    new PVector(" + circlePoint.x + ", " + circlePoint.y + "),");
//   }
//
//   Collections.shuffle(lines, new Random(123456));
//
//   println("  PVector[] circlePoints = {");
//
//   for (String line : lines) {
//     println(line);
//   }
//
//   println("  };");
// }
