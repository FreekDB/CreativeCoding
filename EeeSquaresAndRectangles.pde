// Creative Coding workshop: Squares and Rectangles.
// Freek de Bruijn.
// November, 2020.

// Background color: blue.
color backgroundColor = color(100, 150, 200);

// Stroke color: black.
color strokeColor = color(0);

// Fill color: yellow.
color fillColor = color(250, 180, 20);

// Set the size of our artwork (width, height in pixels).
size(800, 600);
surface.setLocation(10, 560);
surface.setTitle("Creative Coding workshop: Squares and Rectangles");

// Set the background, stroke and fill colors.
background(backgroundColor);
stroke(strokeColor);
fill(fillColor);

// A large square with three smaller squares on top of it.
strokeWeight(1);
square(40, 40, 100);
square(40, 40, 80);
square(40, 40, 60);
square(40, 40, 40);

// Some overlapping rectangles.
strokeWeight(2);
rect(200, 40, 60, 40);
rect(220, 60, 60, 40);
rect(240, 80, 60, 40);
rect(260, 100, 60, 40);

// Some overlapping rectangles with rounded corners.
strokeWeight(3);
rect(410, 40, 40, 40, 12);
rect(400, 60, 60, 40, 12);
rect(390, 80, 80, 40, 12);
rect(380, 100, 100, 40, 12);
