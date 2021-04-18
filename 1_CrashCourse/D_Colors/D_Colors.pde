// Creative Coding workshop: Colors.
// Freek de Bruijn.
// April, 2021.

// Background color: blue.
color backgroundColor = color(100, 150, 200);

// Stroke color: white. This color is used when drawing lines and when drawing borders around shapes.
color strokeColor = color(255);

// Fill color: yellow. This color is used when filling shapes and when draw text.
color fillColor = color(250, 180, 20);

void setup() {
  // Set the size of our artwork (width, height in pixels).
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Colors");
}

void draw() {
  // Set the background, stroke and fill colors.
  background(backgroundColor);
  stroke(strokeColor);
  fill(fillColor);

  // Draw a line with a stroke width of 6 pixels (= line width).
  strokeWeight(6);
  line(40, 40, 760, 40);

  // Draw a filled rectangle with a stroke width of 12 pixels (= border width).
  strokeWeight(12);
  rect(80, 80, 640, 320);

  // Draw some text using the fill color.
  textSize(32);
  text("I love this nice yellow fill color!", 170, 500);
}
