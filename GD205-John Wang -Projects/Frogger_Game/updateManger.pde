//Put all game-related update operations like movement, collision detection together

class UpdateManager {
  void updateCars() {
    for (int i = 0; i < carCount; i++) {
      carX[i] += carSpeed[i];
      if (carX[i] > width) {
        carX[i] = -frogSize * 2; // Wrap cars back to the left
      }
    }
  }

  void updateLogs() {
    for (int i = 0; i < logCount; i++) {
      logX[i] += logSpeed[i];
      if (logX[i] > width) {
        logX[i] = -frogSize * 3; // Wrap logs back to the left
      }
    }
  }

  void checkCollisions() {

    // Car collision check
    for (int i = 0; i < carCount; i++) {
      if (frogY < carY[i] + frogSize && frogY + frogSize > carY[i] &&
        frogX < carX[i] + frogSize * 2 && frogX + frogSize > carX[i]) {
        lives--; // Reduce a life on car collision
        resetFrogPosition(); // Reset the frog to starting position
        if (lives <= 0) {
          stateManager.setState(GameState.GAME_OVER); // End game if no lives left
        }
        return; // Exit the function to avoid double-processing
      }
    }

    if (frogY > height / 2 + roadWidth / 2 && frogY < height / 2 + roadWidth / 2 + riverHeight) {
      boolean onLog = false;
      for (int i = 0; i < logCount; i++) {
        if (frogX + frogSize > logX[i] && frogX < logX[i] + frogSize * 3) {
          onLog = true;
          frogX += logSpeed[i]; // Move frog with the log
          break;
        }
      }
      if (!onLog) {
        lives--; // Reduce a life if frog falls into water
        resetFrogPosition(); // Reset frog position
        if (lives <= 0) {
          stateManager.setState(GameState.GAME_OVER); // End game if no lives left
        }
      }
    }
  }

  // Helper function to reset the frog's position
  void resetFrogPosition() {
    frogX = width / 2 - frogSize / 2;
    frogY = height - frogSize;
  }

  void checkCrossing() {
    // Check if the frog reaches the other side
    if (frogY < height / 2 - roadWidth) {
      score += 100; // Award 100 points for crossing safely
      resetFrogPosition(); // Reset frog position
    }
  }
}
