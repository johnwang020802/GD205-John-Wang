import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;

int gridSize = 10;
int cellSize = 40;
int[][] playerGrid = new int[gridSize][gridSize];
boolean gameStarted = false;
int remainingShips = 5; // Total number of ships

// Define ship sizes
int[] shipSizes = {5, 4, 3, 3, 2};

ShipCounter shipCounter = new ShipCounter(remainingShips);
GameObserver gameObserver = new GameObserver();

void setup() {
  size(500, 500); // Adjusted size for single grid
  placeShips(playerGrid); // Place ships on player grid
  shipCounter.attach(gameObserver);
}

void draw() {
  background(255);
  
  //Display in game text and grid on canvas
  if (!gameStarted) {
    textAlign(CENTER, CENTER);
    textSize(32);
    fill(0);
    text("Click to Start the Game", width / 2, height / 2);
  } else {
    textSize(20);
    fill(0);
    textAlign(CENTER);
    text("Player's Grid", width / 2, 30);
    drawGrid(50, 50, playerGrid); // Adjusted position for single grid
  }
}

// Start and end game
void mousePressed() {
  if (!gameStarted) {
    gameStarted = true;
  } else {
    playGame();
    if (checkVictory(playerGrid)) {
   //   println("Player wins!");
      shipCounter.notifyObservers("Game Over! All ships have been sunk.");
      noLoop();
    }
  }
}

//Determines if player hits ship or misses
void playGame() {
  int x = (mouseX - 50) / cellSize;
  int y = (mouseY - 50) / cellSize;
  if (x >= 0 && y >= 0 && x < gridSize && y < gridSize && playerGrid[x][y] != 2 && playerGrid[x][y] != 3) {
    if (playerGrid[x][y] == 1) {
      playerGrid[x][y] = 2; // Hit
      println("Hit!");
      checkSunkShips();
    } else {
      playerGrid[x][y] = 3; // Miss
      println("Miss!");
    }
  }
}

//Checks grid for hit ships and determines if game ends
boolean checkVictory(int[][] grid) {
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (grid[i][j] == 1) {
        return false;
      }
    }
  }
  return true;
}

//Checks grid for remaining ships and notifies on two and zero remaining
void checkSunkShips() {
  int shipPartsLeft = 0;
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      if (playerGrid[i][j] == 1) {
        shipPartsLeft++;
      }
    }
  }
  if (shipPartsLeft == 2) {
    shipCounter.notifyObservers("Only two ships left!");
  }
  if (shipPartsLeft == 0) {
    shipCounter.decrementShipCount();
  }
}

//Draws grid using cell factory class
void drawGrid(int startX, int startY, int[][] grid) {
  CellFactory cellFactory = new CellFactory();
  for (int i = 0; i < gridSize; i++) {
    for (int j = 0; j < gridSize; j++) {
      Cell cell = cellFactory.getCell(grid[i][j]);
      cell.draw(startX + i * cellSize, startY + j * cellSize, cellSize);
    }
  }
}


//Randomly places ships with the ship factory class
void placeShips(int[][] grid) {
  ShipFactory shipFactory = new ShipFactory();
  for (int size : shipSizes) {
    boolean placed = false;
    while (!placed) {
      int x = int(random(gridSize));
      int y = int(random(gridSize));
      boolean horizontal = random(1) > 0.5;
      Ship ship = shipFactory.getShip(size);
      if (canPlaceShip(grid, x, y, size, horizontal)) {
        ship.place(grid, x, y, horizontal);
        placed = true;
      }
    }
  }
}

//Checks if all ships are placed on grid horizontally and vertically
boolean canPlaceShip(int[][] grid, int x, int y, int size, boolean horizontal) {
  if (horizontal) {
    if (x + size > gridSize) return false;
    for (int i = 0; i < size; i++) {
      if (grid[x + i][y] != 0) return false;
    }
  } else {
    if (y + size > gridSize) return false;
    for (int i = 0; i < size; i++) {
      if (grid[x][y + i] != 0) return false;
    }
  }
  return true;
}
