import java.util.Random;

public class MazeGenerator {
    private final Maze maze;
    private final Random randomGenerator;

    public MazeGenerator(Maze maze, Random randomGenerator) {
        this.maze = maze;
        this.randomGenerator = randomGenerator;
    }

    public void generateMaze() {
        final int curlyLineCount = maze.getMazeHeight() * maze.getMazeWidth();

        for (int curlyLineIndex = 0; curlyLineIndex < curlyLineCount; curlyLineIndex++) {
            final Point startPointCurlyLine = getStartPointCurlyLine();

            if (startPointCurlyLine != null) {
                createCurlyLine(startPointCurlyLine);
            }
        }

        fillRemainingHoles();
    }

    /**
     * Try to find a new starting point for a curly line.
     *
     * @return the start point of the curly line or null if the initial point was not empty.
     */
    private Point getStartPointCurlyLine() {
        final Point startPoint;

        // Find an empty point to start searching.
        int x = 1 + randomGenerator.nextInt(maze.getMazeWidth() - 1);
        int y = 1 + randomGenerator.nextInt(maze.getMazeHeight() - 1);

        if (maze.getCrossPoint(x, y))
            startPoint = null;
        else {
            final int direction = randomGenerator.nextInt(4);
            final int xStep = (direction == Direction.LEFT) ? -1 : ((direction == Direction.RIGHT) ? 1 : 0);
            final int yStep = (direction == Direction.UP) ? -1 : ((direction == Direction.DOWN) ? 1 : 0);

            // Find a point to connect to.
            while (!maze.getCrossPoint(x, y)) {
                x += xStep;
                y += yStep;
            }

            x -= xStep;
            y -= yStep;

            switch (direction) {
                case Direction.LEFT:
                    maze.setHorizontalLine(x - 1, y, true);
                    break;

                case Direction.RIGHT:
                    maze.setHorizontalLine(x, y, true);
                    break;

                case Direction.UP:
                    maze.setVerticalLine(x, y - 1, true);
                    break;

                case Direction.DOWN:
                    maze.setVerticalLine(x, y, true);
                    break;
            }

            maze.setCrossPoint(x, y, true);

            startPoint = new Point(x, y);
        }

        return startPoint;
    }

    /**
     * Create a curly line.
     *
     * @param startPointCurlyLine the start point for this curly line.
     */
    private void createCurlyLine(final Point startPointCurlyLine) {
        int x = startPointCurlyLine.x;
        int y = startPointCurlyLine.y;

        boolean leftPossible = x > 0 && !maze.getCrossPoint(x - 1, y);
        boolean rightPossible = x < maze.getMazeWidth() && !maze.getCrossPoint(x + 1, y);
        boolean upPossible = y > 0 && !maze.getCrossPoint(x, y - 1);
        boolean downPossible = y < maze.getMazeHeight() && !maze.getCrossPoint(x, y + 1);

        while (leftPossible || rightPossible || upPossible || downPossible) {
            final Point nextPoint = addCurlyLineSegment(x, y, leftPossible, rightPossible, upPossible, downPossible);

            x = nextPoint.x;
            y = nextPoint.y;

            leftPossible = x > 0 && !maze.getCrossPoint(x - 1, y);
            rightPossible = x < maze.getMazeWidth() && !maze.getCrossPoint(x + 1, y);
            upPossible = y > 0 && !maze.getCrossPoint(x, y - 1);
            downPossible = y < maze.getMazeHeight() && !maze.getCrossPoint(x, y + 1);
        }
    }

    /**
     * Add a curly line segment.
     *
     * @param x               the current x coordinate: start of this segment.
     * @param y               the current y coordinate: start of this segment.
     * @param leftPossible    whether moving left is possible.
     * @param rightPossible   whether moving right is possible.
     * @param upPossible      whether moving up is possible.
     * @param downPossible    whether moving down is possible.
     * @return the next point in the curly line (end of this segment).
     */
    private Point addCurlyLineSegment(int x, int y, final boolean leftPossible,
                                      final boolean rightPossible, final boolean upPossible,
                                      final boolean downPossible) {
        switch (getNextDirection(leftPossible, rightPossible, upPossible, downPossible)) {
            case Direction.LEFT:
                maze.setHorizontalLine(x - 1, y, true);
                x--;
                break;

            case Direction.RIGHT:
                maze.setHorizontalLine(x, y, true);
                x++;
                break;

            case Direction.UP:
                maze.setVerticalLine(x, y - 1, true);
                y--;
                break;

            case Direction.DOWN:
                maze.setVerticalLine(x, y, true);
                y++;
                break;
        }

        maze.setCrossPoint(x, y, true);

        return new Point(x, y);
    }

    /**
     * Find the direction for the next segment of the curly line.
     *
     * @param leftPossible    whether moving left is possible.
     * @param rightPossible   whether moving right is possible.
     * @param upPossible      whether moving up is possible.
     * @param downPossible    whether moving down is possible.
     * @return the direction.
     */
    private int getNextDirection(final boolean leftPossible, final boolean rightPossible,
                                 final boolean upPossible, final boolean downPossible) {
        boolean directionFound = false;
        int direction = -1;

        while (!directionFound) {
            direction = randomGenerator.nextInt(4);

            switch (direction) {
                case Direction.LEFT:
                    directionFound = leftPossible;
                    break;

                case Direction.RIGHT:
                    directionFound = rightPossible;
                    break;

                case Direction.UP:
                    directionFound = upPossible;
                    break;

                case Direction.DOWN:
                    directionFound = downPossible;
                    break;
            }
        }

        return direction;
    }

    /**
     * Fill the remaining holes in the maze.
     */
    private void fillRemainingHoles() {
        for (int y = 1; y < (maze.getMazeHeight() + 1); y++)
            for (int x = 1; x < (maze.getMazeWidth() + 1); x++)
                if (!maze.getCrossPoint(x, y)) {
                    maze.setCrossPoint(x, y, true);

                    if (randomGenerator.nextBoolean()) {
                        // Connect in the left direction.
                        maze.setHorizontalLine(x - 1, y, true);
                    } else {
                        // Connect in the up direction.
                        maze.setVerticalLine(x, y - 1, true);
                    }
                }
    }
}
