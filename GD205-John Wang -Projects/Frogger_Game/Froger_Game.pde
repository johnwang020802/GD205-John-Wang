// Frogger Game

int frogX, frogY, frogSize = 20;
int carCount = 3;
int[] carX, carY, carSpeed;
int roadWidth = 100;
int riverY, riverHeight = 100;
int logCount = 4;
int[] logX, logY, logSpeed;
int lives = 10;    // Add lives
int score = 0;     // Initialize the score at the start of the game

BufferManager bufferManager;
StateManager stateManager;
GameLoopManager gameLoopManager;
UpdateManager updateManager;

void setup() {
  size(500, 400);
  bufferManager = new BufferManager(width, height);
  stateManager = new StateManager();
  gameLoopManager = new GameLoopManager();
  updateManager = new UpdateManager();
  initializeGame();
}

void initializeGame() {
 
   lives = 10;    // Add lives
   score = 0; // Initialize the score at the start of the game
  
  frogX = width / 2 - frogSize / 2;
  frogY = height - frogSize;

  // Initialize cars
  carX = new int[carCount];
  carY = new int[carCount];
  carSpeed = new int[carCount];
  for (int i = 0; i < carCount; i++) {
    carX[i] = i * width / carCount; // Evenly space cars horizontally
    carY[i] = height / 2 - roadWidth / 2 + i * (roadWidth / carCount); // Place cars on the road
    carSpeed[i] = 1+ i; // Assign different speeds
  }

  // Initialize logs
  logX = new int[logCount];
  logY = new int[logCount];
  logSpeed = new int[logCount];
  for (int i = 0; i < logCount; i++) {
    logX[i] = i * width / logCount; // Evenly space logs horizontally
    logY[i] = height / 2 + roadWidth / 2 + i * 30; // Stagger logs vertically
    logSpeed[i] = 0 + i; // Assign different speeds
  }

  // Position the fourth log at the bottom of the river
  logY[logCount - 1] = height / 2 + roadWidth / 2 + (logCount - 1) * 30; // Explicitly place the bottom log
}


void draw() {
  if (stateManager.getState() == GameState.PLAYING) {

    // BufferManager bufferManager = bufferManager; // Access the double buffer manager

    // Use next buffer for rendering
    PGraphics renderBuffer = bufferManager.getNextBuffer();

    renderBuffer.beginDraw();
    renderBuffer.background(50);
    gameLoopManager.render(renderBuffer); // Render game objects
    renderBuffer.endDraw();

    // Display the current buffer
    image(bufferManager.getCurrentBuffer(), 0, 0);

    // Swap buffers
    bufferManager.swapBuffers();
    

    // Update game logic
    gameLoopManager.update();
  } else if (stateManager.getState() == GameState.MENU) {
    drawMenu();
  } else if (stateManager.getState() == GameState.GAME_OVER) {
    drawGameOver();
  }
}


void drawMenu() {
  background(0);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Press SPACE to Start", width / 2, height / 2);
}

void drawGameOver() {
  background(50);
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  textSize(20);
  text("Game Over! Press R to Restart", width / 2, height / 2);
}

void keyPressed() {
  if (stateManager.getState() == GameState.MENU && key == ' ') {
    stateManager.setState(GameState.PLAYING);
  } else if (stateManager.getState() == GameState.GAME_OVER && key == 'r') {
    stateManager.setState(GameState.PLAYING);
    initializeGame();
  } else if (stateManager.getState() == GameState.PLAYING) {
    
   //Allow frog moving
    if (keyCode == UP) frogY -= 20;
    if (keyCode == DOWN) frogY += 20;
    if (keyCode == LEFT) frogX -= 20;
    if (keyCode == RIGHT) frogX += 20;

    // Keep frog within screen boundaries
    if (frogX > width) frogX = 0;
    if (frogX < 0) frogX = width;
    if (frogY > height) frogY = 0;
    if (frogY < 0) frogY = height;
  }
}


// Functions of drawing game elements

void drawRoadAndRiver(PGraphics pg) {
  pg.fill(100);
  pg.rect(0, height / 2 - roadWidth / 2, width, roadWidth);

  pg.fill(0, 0, 255);
  pg.rect(0, height / 2 + roadWidth / 2, width, riverHeight);

  pg.fill(0, 255, 0);
  for (int i = 0; i < 15; i++) {
    pg.rect(i * 40, height / 2 - roadWidth - 20, 20, 40);
    pg.rect(i * 40, height / 2 + roadWidth + riverHeight + 20, 20, 40);
  }
}

void drawFrog(PGraphics pg) {
  pg.fill(0, 255, 0);
  pg.ellipse(frogX + frogSize / 2, frogY + frogSize / 2, frogSize, frogSize);
  pg.fill(255);
  pg.ellipse(frogX + frogSize / 4, frogY + frogSize / 4, 5, 5);
  pg.ellipse(frogX + 3 * frogSize / 4, frogY + frogSize / 4, 5, 5);
}

void drawCars(PGraphics pg) {
  for (int i = 0; i < carCount; i++) {
    pg.fill(255, 0, 0);
    pg.rect(carX[i], carY[i], frogSize * 2, frogSize);
    pg.fill(0);
    pg.ellipse(carX[i] + 5, carY[i] + frogSize, 10, 10);
    pg.ellipse(carX[i] + frogSize * 2 - 5, carY[i] + frogSize, 10, 10);
  }
}

void drawLogs(PGraphics pg) {
  for (int i = 0; i < logCount; i++) {
    pg.fill(139, 69, 19); // Brown color for logs
    pg.rect(logX[i], logY[i], frogSize * 3, frogSize / 2); // Draw each log
  }
}

void drawLives(PGraphics pg) {
  pg.fill(255); // White color for text
  pg.textSize(16);
  pg.textAlign(LEFT, TOP);
  pg.text("Lives: " + lives, 10, 10); // Display lives at the top-left corner
}

void drawScore(PGraphics pg) {
    pg.fill(255); // White color for the score text
    pg.textSize(16);
    pg.textAlign(RIGHT, TOP);
    pg.text("Score: " + score, width - 10, 10); // Display score in the top-right corner
}
