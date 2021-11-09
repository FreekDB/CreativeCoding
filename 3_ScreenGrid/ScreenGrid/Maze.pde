/**
 * Maze with a specific width and height. Start and end point specify the entrance and exit of the maze.
 */
public class Maze {
    private final int cellHeight;
    private final int cellWidth;

    private final int mazeHeight;
    private final int mazeWidth;

    // todo: Using a point to specify the start and end point can be ambiguous.
    //       For example, the point (0, 0) can be on the left border and the upper border.
    //       This could be solved by adding a startEntranceHorizontal = true|false.
    private final Point startPoint;
    private final Point endPoint;

    private final boolean[][] crossPoints;
    private final boolean[][] horizontalLines;
    private final boolean[][] verticalLines;

    public Maze(final MazeParameters mazeParameters) {
        this.cellHeight = 6;
        this.cellWidth = 6;

        this.mazeHeight = mazeParameters.getMazeHeight();
        this.mazeWidth = mazeParameters.getMazeWidth();

        this.startPoint = mazeParameters.getStartPoint();
        this.endPoint = mazeParameters.getEndPoint();

        this.crossPoints = new boolean[mazeHeight + 1][mazeWidth + 1];
        this.horizontalLines = new boolean[mazeHeight + 1][mazeWidth];
        this.verticalLines = new boolean[mazeHeight][mazeWidth + 1];

        makeBorders();
    }

    private void makeBorders() {
        for (int x = 0; x < (mazeWidth + 1); x++) {
            crossPoints[0][x] = true;
            crossPoints[mazeHeight][x] = true;

            if (x < mazeWidth) {
                horizontalLines[0][x] = true;
                horizontalLines[mazeHeight][x] = true;
            }
        }

        for (int y = 0; y < (mazeHeight + 1); y++) {
            crossPoints[y][0] = true;
            crossPoints[y][mazeWidth] = true;

            if (y < mazeHeight) {
                verticalLines[y][0] = true;
                verticalLines[y][mazeWidth] = true;
            }
        }
    }

    public int getCellHeight() {
        return cellHeight;
    }

    public int getCellWidth() {
        return cellWidth;
    }

    public int getMazeHeight() {
        return mazeHeight;
    }

    public int getMazeWidth() {
        return mazeWidth;
    }

    public boolean getCrossPoint(int x, int y) {
        return crossPoints[y][x];
    }

    public void setCrossPoint(int x, int y, boolean value) {
        crossPoints[y][x] = value;
    }

    public boolean getHorizontalLine(int x, int y) {
        return horizontalLines[y][x];
    }

    public void setHorizontalLine(int x, int y, boolean value) {
        horizontalLines[y][x] = value;
    }

    public boolean getVerticalLine(int x, int y) {
        return verticalLines[y][x];
    }

    public void setVerticalLine(int x, int y, boolean value) {
        verticalLines[y][x] = value;
    }

    public boolean[][] getCrossPoints() {
        return crossPoints;
    }

    public boolean[][] getHorizontalLines() {
        return horizontalLines;
    }

    public boolean[][] getVerticalLines() {
        return verticalLines;
    }

    public Point getStartPoint() {
        return startPoint;
    }

    public Point getEndPoint() {
        return endPoint;
    }

    public void printMaze() {
        for (int rowIndex = 0; rowIndex < mazeHeight; rowIndex++) {
            printCrossPointsAndHorizontalLines(rowIndex);
            printVerticalLines(rowIndex);
        }

        printCrossPointsAndHorizontalLines(mazeHeight);
    }

    private void printCrossPointsAndHorizontalLines(int rowIndex) {
        for (int columnIndex = 0; columnIndex < mazeWidth; columnIndex++) {
            System.out.print(crossPoints[rowIndex][columnIndex] ? "*" : " ");

            String opening = null; // todo: Start/end point ambiguous!  checkOpening(rowIndex, columnIndex);

            //noinspection ConstantConditions
            System.out.print(opening != null ? opening : (horizontalLines[rowIndex][columnIndex] ? "-" : " "));
        }

        System.out.println(crossPoints[rowIndex][mazeWidth] ? "*" : " ");
    }

    private void printVerticalLines(int rowIndex) {
        for (int columnIndex = 0; columnIndex < mazeWidth + 1; columnIndex++) {
            String opening = checkOpening(rowIndex, columnIndex);

            System.out.print((verticalLines[rowIndex][columnIndex] ? "|" : " ") + (opening != null ? opening : " "));
        }

        System.out.println();
    }

    private String checkOpening(int rowIndex, int columnIndex) {
        return ((rowIndex == startPoint.y) && (columnIndex == startPoint.x)) ? "S" :
                (((rowIndex == endPoint.y) && (columnIndex == endPoint.x)) ? "E" : null);
    }
}
