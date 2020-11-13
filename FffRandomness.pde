// Creative Coding workshop: Randomness.
// Freek de Bruijn.
// November, 2020.

// Setup with one-time initialization. (This function is called by Processing when it starts the program.)
void setup() {
  // Set the size of our artwork (width, height in pixels).
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Randomness");

  // Create white lines.
  stroke(255);

  // Prevent the draw function below to be called continuously. For this program, the draw function will be called
  // whenever the user presses a mouse button.
  noLoop();
}

// Draw instructions to update the screen. (This function is called by Processing. For this program, Processing calls
// the draw function only when redraw is called, see the mousePressed function below. Normally, this function is called
// very often, but the noLoop function stops this.)
void draw() {
  // Pick random color parts to create a random background color.
  int redPart = int(random(255));
  int greenPart = int(random(255));
  int bluePart = int(random(255));
  background(redPart, greenPart, bluePart);

  // Pick a random number of lines to draw (from 10 up to 1,000).
  int lineCount = int(random(10, 1000));
  println("The algorithm has decided to draw " + lineCount + " lines.");

  // Repeat the following block for each line we want to draw (lineCount times).
  for (int lineIndex = 0; lineIndex < lineCount; lineIndex++) {
    // Pick two random points on the display window to form a random line.
    float x1 = random(0, width);
    float y1 = random(0, height);
    float x2 = random(0, width);
    float y2 = random(0, height);

    // Draw a line between the two random points.
    line(x1, y1, x2, y2);
  }
}

// Click mouse button: create a completely new artwork!
void mouseClicked() {
  // Calling the redraw function makes sure the draw function above is called once.
  redraw();
}
