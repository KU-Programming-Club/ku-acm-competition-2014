import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Scanner;

class Main {

    static enum Dir {UP, DOWN, LEFT, RIGHT}

    static class Coord {
        public Coord(final int x, final int y) {
            this.x = x;
            this.y = y;
        }

        final int x;
        final int y;

        @Override
        public int hashCode() {
            return Objects.hash(x, y);
        }

        @Override
        public boolean equals(Object o) {
            if (o instanceof Coord) {
                Coord c = (Coord) o;
                return x == c.x && y == c.y;
            } else {
                return false;
            }
        }
    }

    public static void main(String[] args) {
        Scanner stdin = new Scanner(System.in);

        while (true) {
            final int r = stdin.nextInt();
            final int c = stdin.nextInt();
            final int x = stdin.nextInt();
            final int y = stdin.nextInt();

            if (r == 0 && c == 0 && x == 0 && y == 0) {
                break;
            } else {
                stdin.nextLine();

                Dir[][] labyrinth = new Dir[r][c];
                for (int i = 0; i < r; ++i) {
                    final String line = stdin.nextLine().trim().substring(0, c);
                    for (int j = 0; j < c; ++j) {
                        switch (line.charAt(j)) {
                            case 'U':
                                labyrinth[i][j] = Dir.UP;
                                break;
                            case 'D':
                                labyrinth[i][j] = Dir.DOWN;
                                break;
                            case 'L':
                                labyrinth[i][j] = Dir.LEFT;
                                break;
                            case 'R':
                                labyrinth[i][j] = Dir.RIGHT;
                                break;
                        }
                    }
                }

                Map<Coord, Integer> visited = new HashMap<Coord, Integer>();
                visited.put(new Coord(x, y), 0);
                int steps = 0;

                int curX = x;
                int curY = y;

                while (true) {
                    switch (labyrinth[curX][curY]) {
                        case UP:
                            --curX;
                            break;
                        case DOWN:
                            ++curX;
                            break;
                        case LEFT:
                            --curY;
                            break;
                        case RIGHT:
                            ++curY;
                            break;
                    }

                    steps++;
                    //System.out.println(curX + ", " + curY + ", " + steps);
                    final Coord newc = new Coord(curX, curY);
                    if (visited.containsKey(newc)) {
                        final int prevSteps = visited.get(newc);
                        System.out.println(prevSteps + " steps before loop with " + (steps - prevSteps) + " steps");
                        break;
                    } else if (curX < 0 || curX >= r || curY < 0 || curY >= c) {
                        //System.out.println(r + ", " + c);
                        System.out.println(steps + " steps to exit");
                        break;
                    } else {
                        visited.put(newc, steps);
                    }
                }
            }
        }
    }
}