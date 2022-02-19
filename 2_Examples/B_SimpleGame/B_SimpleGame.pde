// Step 1: set the window size.
void setup() {
  size(400, 600);
}

// Step 4: draw the shape.
int shapeX = 100;
int shapeY = 0;
int shapeSize = 40;

// Step 5: keep the score.
int score = 0;

// Step 1: draw function.
void draw() {
  // Step 3: erase the previous drawing.
  background(100, 150, 200);

  // Step 1: draw some lines.
  stroke(0);
  strokeWeight(6);
  line(10, 10, 390, 10);
  line(10, 10, 10, 590);
  line(390, 10, 390, 590);

  // Step 2: draw the paddle.
  int paddleWidth = 100;
  int paddleX = mouseX - paddleWidth / 2;
  stroke(255);
  strokeWeight(12);
  line (paddleX, 588, paddleX + paddleWidth, 588);

  // Step 4: draw the shape.
  shapeY = shapeY + 6;
  fill(250, 180, 20);
  stroke(250, 180, 20);
  strokeWeight(6);
  square(shapeX, shapeY, shapeSize);
  
  // Step 5: detect collisions.
  if (shapeY > height - shapeSize) {
    if (paddleX <= shapeX && paddleX + paddleWidth >= shapeX + shapeSize) {
      score = score + 1;
    }
    
    // Step 6: reset the shape position.
    shapeX = 20 + int(random(width - shapeSize - 40));
    shapeY = 0;
  }

  // Step 5: show the score.
  fill(255);
  textSize(20);
  text("Score: " + score, width - 120, 40);
}
