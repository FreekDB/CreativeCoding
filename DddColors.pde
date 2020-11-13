// Creative Coding workshop: Colors.
// Freek de Bruijn.
// November, 2020.

// Background color: blue.
color backgroundColor = color(100, 150, 200);

// Stroke color: white. This color is used to draw lines and borders around shapes.
color strokeColor = color(255);

// Fill color: yellow. This color is used to fill shapes and draw text.
color fillColor = color(250, 180, 20);

// Set the size of our artwork (width, height in pixels).
size(800, 600);
surface.setLocation(10, 560);
surface.setTitle("Creative Coding workshop: Colors");

// Set the background, stroke and fill colors.
background(backgroundColor);
stroke(strokeColor);
fill(fillColor);

// Draw a rectangle with a stroke width of 12 pixels (= border width).
strokeWeight(12);
rect(80, 80, 640, 320);

strokeWeight(6);
line(40, 40, 760, 40);

// Text is drawn in fill color.
textSize(32);
text("I love this yellow fill color!", 192, 500);
