boolean[][] cells;
boolean[][] newCells;

int n = 50;
float cellSize;
float padding = 50;
int blinksPerSecond = 5; //used in the call to frameRate() inside setup()

void setup(){
  size(800,800);
  cellSize = (width-2*padding)/n;
  cells = new boolean[n][n];
  newCells = new boolean[n][n];
  setCellValuesRandomly();
  frameRate( blinksPerSecond );
}


void draw() {  
  background(0);
  float y = padding;
  for (int j=0; j<n; j++) {
    for(int i=0; i<n; i++) {
      float x = padding + i*cellSize;

      if (cells[i][j])
        fill(255,255,0);
        
      else
        fill(120);
        
      square(x, y, cellSize);
    }
    y = padding+ j*cellSize;
  }
  
  newGen();
  for(int i=0; i<n; i++) 
   for(int j=0; j<n; j++) 
       cells[i][j] = newCells[i][j];

}


void setCellValuesRandomly() {
  for (int j=0; j<n; j++) {
    for(int i = 0; i < n; i++) {
      int x = round(random(0,1));
      
      if (x == 0)
        cells[i][j] = false;
        
      else
        cells[i][j] = true;
    }
  }
}

void newGen() {
  for (int j=0; j<n; j++) {
    for(int i = 0; i < n; i++) {
      int aliveNeighbours = coundAliveNeighbours(i,j);
      if (cells[i][j])
        if (aliveNeighbours == 2 || aliveNeighbours == 3)
          newCells[i][j] = true;
        else
          newCells[i][j] = false;
      else
        if (aliveNeighbours == 3)
          newCells[i][j] = true;
        else 
          newCells[i][j] = false;
    }
  }
}

int coundAliveNeighbours(int row,int col) {
  int count = 0;
  for (int a=-1; a <= 1; a++) {
    for(int b = -1; b <= 1; b++) {
      try {
        if (cells[row+b][col+a]==true && !(a==0 && b==0))
          count ++;  
      }
      catch (Exception e) {
        
      }
        
    }
  }
  return count;
}
