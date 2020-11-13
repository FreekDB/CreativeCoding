// Creative Coding workshop: Text.
// Freek de Bruijn.
// November, 2020.

color backgroundColor = color(100, 150, 200);
color strokeColor = color(255);

// Initialization.
void setup() {
  size(800, 600);
  surface.setLocation(10, 560);
  surface.setTitle("Creative Coding workshop: Text");
  
  stroke(strokeColor);
  strokeWeight(2);
  noFill();

  textSize(28);
}

int visibleItemCount = 1;
int totalItemCount = 3;

// Draw a frame.
void draw() {
  background(backgroundColor);
  
  if (visibleItemCount >= 1) {
    rect(60, 100, 680, 200);
  }
  
  if (visibleItemCount >= 2) {
    text("rect(60, 100, 680, 200);", 100, 180);
  }

  if (visibleItemCount >= 3) {
    text("text(\"rect(60, 100, 680, 200);\", 100, 180);", 100, 240);
  }
}

// Click left mouse button: increase visible item count or reset to one. 
// Click right mouse button: go back. 
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
