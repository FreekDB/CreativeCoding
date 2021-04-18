// Creative Coding workshop: Squares and Rectangles.
// Freek de Bruijn.
// April, 2021.

// Background color: blue.
color backgroundColor = color(100, 150, 200);

// Stroke color: black.
color strokeColor = color(0);

// Fill color: yellow.
color fillColor = color(250, 180, 20);

void setup() {
  // Set the size of our artwork (width, height in pixels).
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Squares and Rectangles");
}

void draw() {
  // Set the background, stroke and fill colors.
  background(backgroundColor);
  stroke(strokeColor);
  fill(fillColor);

  // A large square with three smaller squares on top of it.
  // Draw the borders with a stroke width of 1 pixels (= border width).
  strokeWeight(1);
  square(40, 40, 100);
  square(40, 40, 80);
  square(40, 40, 60);
  square(40, 40, 40);

  // Some overlapping rectangles.
  // Draw the borders with a stroke width of 2 pixels (= border width).
  strokeWeight(2);
  rect(200, 40, 60, 40);
  rect(220, 60, 60, 40);
  rect(240, 80, 60, 40);
  rect(260, 100, 60, 40);

  // Some overlapping rectangles with rounded corners.
  // Draw the borders with a stroke width of 3 pixels (= border width).
  strokeWeight(3);
  rect(410, 40, 40, 40, 12);
  rect(400, 60, 60, 40, 12);
  rect(390, 80, 80, 40, 12);
  rect(380, 100, 100, 40, 12);
}
