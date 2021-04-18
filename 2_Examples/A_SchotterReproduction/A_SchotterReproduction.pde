// Georg Nees - Schotter (the German word for gravel).
// http://dada.compart-bremen.de/item/algorithm/1
// https://miro.medium.com/max/2609/1*jT94Smc6DX23VlnJk96INg.jpeg

// Reproduction by Jim Plaxco (www.artsnova.com).
// http://www.artsnova.com/Nees_Schotter_Tutorial.html

// Refactored and slightly modified by Freek de Bruijn.

color blackColor = color(0, 0, 0);
color whiteColor = color(255, 255, 255);

int columnCount = 12;
int rowCount = 22;
int squareSize = 30;
int edgeSize = 3 * squareSize;
int windowWidth = columnCount * squareSize + 2 * edgeSize;

float randomIncrement = 0.22;
float dampen = 0.45;
float growingDisorder = 0.0;

void setup() {
  // println("Window width: " + (columnCount * squareSize + 2 * edgeSize));
  // println("Window height: " + (rowCount * squareSize + 2 * edgeSize));
  size(540, 840);

  background(whiteColor);
  stroke(blackColor);
  smooth();
  noFill();
  noLoop();
}

void draw() {
  for (int rowIndex = 0; rowIndex < rowCount; rowIndex++) {
    growingDisorder += rowIndex * randomIncrement;

    for (int columnIndex = 0; columnIndex < columnCount; columnIndex++) {
      pushMatrix();

      // Pick a random amount of disorder for rotation and translation.
      float rotationDisorder = random(-growingDisorder, growingDisorder);
      float translationDisorder = rotationDisorder * dampen;

      translate(edgeSize + columnIndex * squareSize + translationDisorder,
                edgeSize + rowIndex * squareSize + translationDisorder);

      rotate(radians(rotationDisorder));

      square(0, 0, squareSize);

      popMatrix();
    }
  }
}
