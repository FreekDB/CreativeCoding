import java.util.Random;

public class MazeParameters {
    private final int mazeHeight;
    private final int mazeWidth;
    private final Point startPoint;
    private final Point endPoint;
    private final Random randomGenerator;

    public MazeParameters(int mazeHeight, int mazeWidth, Point startPoint, Point endPoint, Random randomGenerator) {
        this.mazeHeight = mazeHeight;
        this.mazeWidth = mazeWidth;
        this.startPoint = startPoint;
        this.endPoint = endPoint;
        this.randomGenerator = randomGenerator;
    }

    public int getMazeHeight() {
        return mazeHeight;
    }

    public int getMazeWidth() {
        return mazeWidth;
    }

    public Point getStartPoint() {
        return startPoint;
    }

    public Point getEndPoint() {
        return endPoint;
    }

    public Random getRandomGenerator() {
        return randomGenerator;
    }
}
