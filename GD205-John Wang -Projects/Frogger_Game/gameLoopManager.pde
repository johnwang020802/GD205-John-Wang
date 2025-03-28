//Organizes the overall flow of the game, 
//Ensuring updates and rendering happen in the correct sequence during each frame.

class GameLoopManager {
  void update() {
    // Delegate updates to the UpdateManager
    updateManager.updateCars();
    updateManager.updateLogs();
    updateManager.checkCollisions();
    updateManager.checkCrossing(); // Check if the frog completed a crossing

  }

  void render(PGraphics buffer) {
    // Render game elements
    drawRoadAndRiver(buffer);
    drawFrog(buffer);
    drawCars(buffer);
    drawLogs(buffer);
    drawLives(buffer); // Show lives
    drawScore(buffer); // Show score
  }
}
