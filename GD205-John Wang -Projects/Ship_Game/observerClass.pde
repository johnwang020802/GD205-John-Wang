// Observer Interface
interface Observer {
  void update(String message);
}

// ConcreteObserver
class GameObserver implements Observer {
  public void update(String message) {
    println(message);
  }
}
