public class MultiMazeView {
  private static final int CELL_GROUP_WIDTH = 4;
  private static final int CELL_GROUP_HEIGHT = 4;
  private static final int BORDER_SIZE = 2;
  private static final int CELL_WIDTH = (50 - (CELL_GROUP_WIDTH + 1) * BORDER_SIZE) / CELL_GROUP_WIDTH;
  private static final int CELL_HEIGHT = (50 - (CELL_GROUP_HEIGHT + 1) * BORDER_SIZE) / CELL_GROUP_HEIGHT;

  private final int firstCellX = 120 + BORDER_SIZE;
  private final int firstCellY = 360 + BORDER_SIZE;

  private final int cellGroupWidthPixels = CELL_GROUP_WIDTH * CELL_WIDTH + (CELL_GROUP_WIDTH + 1) * BORDER_SIZE;
  private final int cellGroupHeightPixels = CELL_GROUP_HEIGHT * CELL_HEIGHT + (CELL_GROUP_HEIGHT + 1) * BORDER_SIZE;

  private int cellGroupColumnCount;
  private int cellGroupRowCount;

  private int extraBetweenGroupsX = 60;
  private int extraBetweenGroupsY = 60;

  private Maze maze;

  public MultiMazeView(Maze maze) {
    this.maze = maze;

    cellGroupColumnCount = maze.getMazeWidth() / CELL_GROUP_WIDTH;
    cellGroupRowCount = maze.getMazeHeight() / CELL_GROUP_HEIGHT;
  }

  public void drawMaze() {
    background(0);
    stroke(255);
    fill(0);
    strokeWeight(BORDER_SIZE);

    for (int cellGroupRowIndex = 0; cellGroupRowIndex < cellGroupRowCount; cellGroupRowIndex++) {
      for (int cellGroupColumnIndex = 0; cellGroupColumnIndex < cellGroupColumnCount; cellGroupColumnIndex++) {
        drawCellGroup(cellGroupColumnIndex, cellGroupRowIndex);
      }
    }
  }

  private void drawCellGroup(int cellGroupColumnIndex, int cellGroupRowIndex) {
    int x = firstCellX + cellGroupColumnIndex * (cellGroupWidthPixels + extraBetweenGroupsX);
    int y = firstCellY + cellGroupRowIndex * (cellGroupHeightPixels + extraBetweenGroupsY);
  
    stroke(0);
    rect(x, y, cellGroupWidthPixels, cellGroupHeightPixels);
    stroke(255);
    
    int cellRowOffset = cellGroupRowIndex * CELL_GROUP_HEIGHT;
    int cellColumnOffset = cellGroupColumnIndex * CELL_GROUP_WIDTH;
    
    // Draw cross points.
    for (int cellRowIndex = 0; cellRowIndex < CELL_GROUP_HEIGHT + 1; cellRowIndex++) {
      for (int cellColumnIndex = 0; cellColumnIndex < CELL_GROUP_WIDTH + 1; cellColumnIndex++) {
        if (maze.getCrossPoint(cellColumnOffset + cellColumnIndex, cellRowOffset + cellRowIndex)) {
          square(x + cellColumnIndex * (CELL_WIDTH + BORDER_SIZE),
                 y + cellRowIndex * (CELL_HEIGHT + BORDER_SIZE),
                 BORDER_SIZE / 2);
        }
      }
    }

    // Draw horizontal lines.
    for (int cellRowIndex = 0; cellRowIndex < CELL_GROUP_HEIGHT + 1; cellRowIndex++) {
      for (int cellColumnIndex = 0; cellColumnIndex < CELL_GROUP_WIDTH; cellColumnIndex++) {
        if (maze.getHorizontalLine(cellColumnOffset + cellColumnIndex, cellRowOffset + cellRowIndex)) {
          float startLineX = x + cellColumnIndex * (CELL_WIDTH + BORDER_SIZE) + 1.5 * BORDER_SIZE;
          float startLineY = y + cellRowIndex * (CELL_HEIGHT + BORDER_SIZE) + 0.5 * BORDER_SIZE; 

          line(startLineX, startLineY, startLineX + CELL_WIDTH, startLineY);
        }
      }
    }
    
    // Draw vertical lines.
    for (int cellRowIndex = 0; cellRowIndex < CELL_GROUP_HEIGHT; cellRowIndex++) {
      for (int cellColumnIndex = 0; cellColumnIndex < CELL_GROUP_WIDTH + 1; cellColumnIndex++) {
        if (maze.getVerticalLine(cellColumnOffset + cellColumnIndex, cellRowOffset + cellRowIndex)) {
          float startLineX = x + cellColumnIndex * (CELL_WIDTH + BORDER_SIZE) + 0.5 * BORDER_SIZE;
          float startLineY = y + cellRowIndex * (CELL_HEIGHT + BORDER_SIZE) + 1.5 * BORDER_SIZE; 

          line(startLineX, startLineY, startLineX, startLineY + CELL_HEIGHT);
        }
      }
    }
  }
  
  public void toggleExtraBetweenGroups() {
    extraBetweenGroupsX = 60 - BORDER_SIZE - extraBetweenGroupsX;
    extraBetweenGroupsY = 60 - BORDER_SIZE - extraBetweenGroupsY;
  }
}
