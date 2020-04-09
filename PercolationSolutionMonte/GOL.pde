// Wieslaw Bartkowski
// Dla Tamary 2020

class GOL {

  int w = 8;
  int columns, rows;

  // Game of life board
  int[][] board;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = width/w;
    rows = height/w;
    board = new int[columns][rows];
    //next = new int[columns][rows];
    // Call function to fill array with random values 0 or 1
    init();
  }

  void init() {
    board[columns/2][rows/2] = 1;
  }

  // The process of creating the new generation
  void generate() {
    // montecarlo
    for (int n = 1; n < columns*rows; n++) {
      int x = int(random(columns));
      int y = int(random(rows));
      for (int k = 1; k < 9; k++) {
        int i = int(random(-2, 2));
        int j = int(random(-2, 2));
        if (board[x][y] == 1 && random(100)<53) board[x+i][y+j] = 1;
      }
      board[x][y] = 0;
    }
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        if ((board[i][j] == 1)) fill(0);
        else fill(255); 
        stroke(0);
        rect(i*w, j*w, w, w);
      }
    }
  }
}
