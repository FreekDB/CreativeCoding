// Description: Periodic Table, Newton's Cradle, Lines Through Point, Rainbow, Confetti and Maze on a grid of screens.
// Author: Freek de Bruijn.
// Date: November 2021.

// Google: newton's cradle physics forces metal balls
// Inspired by: https://stackoverflow.com/questions/59549997/my-code-for-this-newtons-cradle-isnt-working-how-do-i-fix-this


// Other interesting links related to network communication and client-server connections:
// https://processing.org/reference/libraries/net/index.html
// https://processing.org/reference/libraries/net/Client.html

// Time synchronization:
// https://stackoverflow.com/questions/4442192/how-to-use-an-internet-time-server-to-get-the-time


/*
import java.net.InetAddress;
import java.util.Date;
import org.apache.commons.net.ntp.NTPUDPClient;
import org.apache.commons.net.ntp.TimeInfo;
*/


String[] programs = new String[] {"Periodic Table", "Newton's Cradle", "Lines Through Point", "Rainbow", "Confetti", "Maze"};
int activeProgramIndex = 0;
String activeProgram = programs[activeProgramIndex];

boolean drawBuildingFacade = true;


// Periodic Table.
PImage backgroundPeriodicTable;


// Newton's Cradle.
PVector start1;
PVector end1;
PVector start2;
PVector end2;

float cordLength = 350;
int actPendle = 1;
float angleIncrement1 = 0.05;
float angleIncrement2 = 0.05;
float angle1 = 0;
float angle2 = 0;


// Maze
MultiMazeView multiMazeView;


void setup() {
  backgroundPeriodicTable = loadImage("periodic-table.jpg");

  size(1820, 1000);

  setFrameRate();

  start1 = new PVector(950, 300);
  end1 = new PVector();
  start2 = new PVector(650, 300);
  end2 = new PVector();
  
  createMaze();
}

private void createMaze() {
  Random randomGenerator = new Random(123456L);

  Point startPoint = new Point(0, 2);
  Point endPoint = new Point(17, 2);
  MazeParameters mazeParameters = new MazeParameters(3 * 4, 14 * 4, startPoint, endPoint, randomGenerator);

  Maze maze = new Maze(mazeParameters);

  new MazeGenerator(maze, randomGenerator).generateMaze();
  
  multiMazeView = new MultiMazeView(maze);
  
  // maze.printMaze();
}

void draw() {
/*
  // todo: Calculate offset of time server time vs local time.
  if (frameCount % 100000 == 0) {
    Date timeServerDateTime = getTimeServerDateTime();
    Date localDateTime = new Date();
    
    println("Local date/time: " + localDateTime);
    println("Time server date/time: " + timeServerDateTime);
    println();
  }
*/

  if (activeProgram == "Periodic Table") {
    drawPeriodicTable();
  } else if (activeProgram == "Newton's Cradle") {
    drawNewtonsCradle();
  } else if (activeProgram == "Lines Through Point") {
    drawLinesThroughPoint();
  } else if (activeProgram == "Rainbow") {
    drawRainbow();
  } else if (activeProgram == "Confetti") {
    drawConfetti();
  } else if (activeProgram == "Maze") {
    multiMazeView.drawMaze();
  }

  if (drawBuildingFacade) {
    drawFacade();
  }
}

private void drawPeriodicTable() {
  background(0);
  image(backgroundPeriodicTable, mouseX * 4 - 600, mouseY * 4 - 400);
}  

private void drawNewtonsCradle() {
  background(20);

  stroke(255);
  strokeWeight(10);
  fill(255);
  ellipse(850, 650, 100, 100);
  ellipse(750, 650, 100, 100);
  line(750, 300, 750, 600);
  line(850, 300, 850, 600);

  end1.x = start1.x + cordLength * sin(angle1);
  end1.y = start1.y + cordLength * cos(angle1);
  end2.x = start2.x + cordLength * sin(angle2);
  end2.y = start2.y + cordLength * cos(angle2);

  ellipse(end1.x, end1.y, 100, 100);
  ellipse(end2.x, end2.y, 100, 100);
  line(start1.x, start1.y, end1.x, end1.y);
  line(start2.x, start2.y, end2.x, end2.y);

  if (actPendle == 1) {
      angle1 += angleIncrement1;
      if (angle1 > 1) {
        angleIncrement1 *= -1;
      } else if (angle1 < 0) {
        angleIncrement1 *= -1;
        actPendle = 2;
      }
  }

  if (actPendle == 2) {
      angle2 -= angleIncrement2;
      if (angle2 < -1){
        angleIncrement2 *= -1;
      } else if (angle2 > 0) {
        angleIncrement2 *= -1;
        actPendle = 1;
      }
  }
}

private void drawLinesThroughPoint() {
  int colorPart = 32 + ((4 * frameCount) % 128);
  int redPart = (frameCount / 32) % 4 == 0 ? colorPart : 255;
  int greenPart = (frameCount / 32) % 4 == 1 ? colorPart : 255;
  int bluePart = (frameCount / 32) % 4 == 2 ? colorPart : 255;
  
  background(0);
  stroke(redPart, greenPart, bluePart);
  strokeWeight(2);

  for (int y = 100; y < height - 100; y += 30) {
    line (100, 100, width - 100, y);
  }

  for (int x = width - 100; x > 100; x -= 50) {
    line (100, 100, x, height - 100);
  }
}

private void drawRainbow() {
  // https://upload.wikimedia.org/wikipedia/commons/0/07/1330px_Rainbow_flag_12_colours_black_bordered.svg
  color[] rainbowColors = new color[] {
      color(0xFF962192), color(0xFF5228CC), color(0xFF0433FF), color(0xFF009292), color(0xFF00F900), color(0xFFCAFA00),
      color(0xFFFFFB00), color(0xFFFFC700), color(0xFFFF9300), color(0xFFFF5000), color(0xFFFF2600), color(0xFFD82253)
  };
  
  background(0);
  
  int stripeHeight = 20;
  int yOffset = -(frameCount % 500);
  
  for (int rainbowIndex = 0; rainbowIndex < rainbowColors.length; rainbowIndex++) {
    stroke(rainbowColors[rainbowIndex]);
    fill(rainbowColors[rainbowIndex]);
    rect(100, yOffset + 600 + rainbowIndex * stripeHeight, width - 200, stripeHeight);
  }
}

private void drawConfetti() {
  // https://upload.wikimedia.org/wikipedia/commons/0/07/1330px_Rainbow_flag_12_colours_black_bordered.svg
  color[] rainbowColors = new color[] {
      color(0xFF962192), color(0xFF5228CC), color(0xFF0433FF), color(0xFF009292), color(0xFF00F900), color(0xFFCAFA00),
      color(0xFFFFFB00), color(0xFFFFC700), color(0xFFFF9300), color(0xFFFF5000), color(0xFFFF2600), color(0xFFD82253)
  };
  
  background(0);
  
  for (int ballIndex = 0; ballIndex < 1000; ballIndex++) {
    int x = 100 + int(random(width - 200));
    int y = 100 + int(random(height - 200));
    color randomColor = rainbowColors[int(random(rainbowColors.length))];

    stroke(randomColor);
    fill(randomColor);
    circle(x, y, 16);
  }
}

// Draw the building facade (everything except for the windows) on top of the image/animation.
private void drawFacade() {
  stroke(0, 0, 0);
  fill(0, 0, 0);
  
  int firstWindowX = 120;
  int windowWidth = 50;
  int distanceBetweenWindowsX = 60;

  int firstWindowY = 360;
  int windowHeight = 50;
  int distanceBetweenWindowsY = 60;
  
  //int windowColumnCount = (width - firstWindowX) / (windowWidth + distanceBetweenWindowsX) + 1;
  //int windowRowCount = (height - firstWindowY) / (windowHeight + distanceBetweenWindowsY) + 1;
  
  int windowColumnCount = 14;
  int windowRowCount = 3;
  
  // Assume m rows of n windows: top left x: 60 + 100 * 1..n, y: 200, width: 40, height: 100.

  // Above the first row of windows:
  rect(0, 0, width, firstWindowY);

  for (int rowIndex = 0; rowIndex < windowRowCount; rowIndex++) {
    int windowTopY = firstWindowY + (windowHeight + distanceBetweenWindowsY) * rowIndex;
    
    // In the row of windows:
    int leftX = 0;
    
    for (int columnIndex = 0; columnIndex < windowColumnCount; columnIndex++) {
      int windowLeftX = firstWindowX + (windowWidth + distanceBetweenWindowsX) * columnIndex;
      rect(leftX, windowTopY, windowLeftX - leftX, windowHeight);
      leftX = windowLeftX + windowWidth;
    }
  
    // From right side of last window until the width of the sketch:
    rect(leftX, windowTopY, width - leftX, windowHeight);

    // Between the rows of windows:
    rect(0, windowTopY + windowHeight, width, distanceBetweenWindowsY);
  }
  
  // Below the last row of windows:
  int lastWindowY = firstWindowY + (windowHeight + distanceBetweenWindowsY) * windowRowCount;
  rect(0, lastWindowY, width, height - lastWindowY);
}

void mousePressed() {
  if (mouseButton == LEFT) {
    selectNextProgram();
  } else if (mouseButton == RIGHT) {
    drawBuildingFacade = !drawBuildingFacade;
  }
}

void keyPressed() {
  if (key == ' ') {
    selectNextProgram();
  } else if (key == 'f') {
    drawBuildingFacade = !drawBuildingFacade;
  } else if (key == 's') {
    multiMazeView.toggleExtraBetweenGroups();
  }
}

private void selectNextProgram() {
  activeProgramIndex = (activeProgramIndex + 1) % programs.length;
  activeProgram = programs[activeProgramIndex];

  if (activeProgram == "Maze") {
    drawBuildingFacade = false;
  }

  setFrameRate();
}

private void setFrameRate() {
  int programFrameRate = activeProgram.equals("Confetti") ? 12 : 60;
  frameRate(programFrameRate);
}


/*
private Date getTimeServerDateTime() {
  Date timeServerDateTime = null;

  try {
    final String TIME_SERVER = "time-a.nist.gov";   
    NTPUDPClient timeClient = new NTPUDPClient();
    InetAddress inetAddress = InetAddress.getByName(TIME_SERVER);
    TimeInfo timeInfo = timeClient.getTime(inetAddress);
    long returnTime = timeInfo.getMessage().getTransmitTimeStamp().getTime();
    timeServerDateTime = new Date(returnTime);
  } catch (Exception e) {
    println("Exception while getting the time from the time server: " + e);
  }
  
  return timeServerDateTime;
}
*/
