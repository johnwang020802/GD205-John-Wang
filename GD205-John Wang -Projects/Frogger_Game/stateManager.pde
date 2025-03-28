enum GameState {
  MENU,
  PLAYING,
  GAME_OVER
}

//Tracking and maanging current state of the game. 

class StateManager {
  GameState currentState;

  StateManager() {
    currentState = GameState.MENU;
  }

  void setState(GameState state) {
    currentState = state;
  }

  GameState getState() {
    return currentState;
  }
}
