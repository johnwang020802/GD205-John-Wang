// Subject Interface
interface Subject {
  void attach(Observer observer);
  void detach(Observer observer);
  void notifyObservers(String message);
}

// ConcreteSubject
class ShipCounter implements Subject {
  private List<Observer> observers = new ArrayList<>();
  private int shipCount;

  public ShipCounter(int initialCount) {
    shipCount = initialCount;
  }

  public void attach(Observer observer) {
    observers.add(observer);
  }

  public void detach(Observer observer) {
    observers.remove(observer);
  }

  public void notifyObservers(String message) {
    for (Observer observer : observers) {
      observer.update(message);
    }
  }

//notify subject of ship count 
  public void decrementShipCount() {
    shipCount--;
    if (shipCount == 2) {
      notifyObservers("Only two ships left!");
    } else if (shipCount == 0) {
      notifyObservers("Game Over! All ships have been sunk.");
    }
  }

  public int getShipCount() {
    return shipCount;
  }
}
