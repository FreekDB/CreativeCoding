// Creative Coding workshop: Canvas and Coordinates.
// Freek de Bruijn.
// November, 2020.

color backgroundColor = color(100, 150, 200);
color normalStrokeColor = color(255);
color gridStrokeColor = color(150, 200, 250);

// Initialization.
void setup() {
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Canvas and Coordinates");
  textSize(20);
  stroke(normalStrokeColor);
  strokeWeight(2);
}

boolean showGrid = false;

boolean addOne = true;
int lowOffset = addOne ? 1 : 0;
int highOffset = addOne ? 0 : -1;

int spaceTop = 24;
int spaceLeft = 6;
int spaceBottom = 10;

// Draw a frame.
void draw() {
  background(backgroundColor);

  if (showGrid) {
    drawGrid();
  }

  drawCornerCoordinates();
  drawMouseCoordinates();
}

// The horizontal and vertical middle lines "attract" the mouse.
boolean attractedX = false;
boolean attractedY = false;

void mouseMoved() {
  int middleX = width / 2 - 1;
  int middleY = height / 2 - 1;

  int distanceX = abs(mouseX - middleX);
  int distanceY = abs(mouseY - middleY);
  
  if (distanceX < 28 && !attractedY) {
    mouseX = middleX;
    attractedX = true;
    attractedY = false;
  } else if (distanceY < 28) {
    mouseY = middleY;
    attractedY = true;
    attractedX = false;
  } else {
    attractedX = false;
    attractedY = false;
  }
}

// Click left mouse button: switch the grid on or off. 
// Click right mouse button: switch add one to coordinates on or off. 
void mouseClicked() {
  if (mouseButton == LEFT) {
    showGrid = !showGrid;
  } else {
    addOne = !addOne;
    lowOffset = addOne ? 1 : 0;
    highOffset = addOne ? 0 : -1;
  }
}

// Draw the grid lines.
void drawGrid() {
  stroke(gridStrokeColor);
  
  int gridSpace = 100;
  
  // Horizontal grid lines.
  for (int y = 0; y < height; y += gridSpace) {
    line(0, y, width - 1, y);
  }
  
  // Vertical grid lines.
  for (int x = 0; x < width; x += gridSpace) {
    line(x, 0, x, height - 1);
  }
  
  stroke(normalStrokeColor);
}

// Draw the coordinates of the four corner points.
void drawCornerCoordinates() {
  String textTopRight = (width + highOffset) + ", " + lowOffset;
  String textBottomRight = (width + highOffset) + ", " + (height + highOffset);
  
  int spaceRightTop = 6 + int(textWidth(textTopRight));
  int spaceRightBottom = 6 + int(textWidth(textBottomRight));

  text(lowOffset + ", " + lowOffset, spaceLeft, spaceTop);
  text(textTopRight, width - spaceRightTop, spaceTop);
  text(lowOffset + ", " + (height + highOffset), spaceLeft, height - spaceBottom);
  text(textBottomRight, width - spaceRightBottom, height - spaceBottom);
}

// Draw the mouse coordinates and crosshairs.
void drawMouseCoordinates() {
  int far = 28;
  int close = 12;
  int offsetX = 6;
  int offsetY = 4;

  String locationText = (mouseX + lowOffset) + ", " + (mouseY + lowOffset);
  int spaceRight = 6 + int(textWidth(locationText));
  int centerX = constrain(mouseX, max(spaceLeft, offsetX + far + 6), width - spaceRight);
  int centerY = constrain(mouseY, max(spaceTop, offsetY + far + 3), height - max(spaceBottom, far - offsetY + 6));
  text(locationText, centerX, centerY - 11);

  line(centerX - offsetX, centerY - far - offsetY, centerX - offsetX, centerY - close - offsetY);
  line(centerX - offsetX - far, centerY - offsetY, centerX - offsetX - close, centerY - offsetY);
  line(centerX - offsetX + close, centerY - offsetY, centerX - offsetX + far, centerY - offsetY);
  line(centerX - offsetX, centerY + close - offsetY, centerX - offsetX, centerY + far - offsetY);
}
