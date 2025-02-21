// Flyweight Ship class
class Ship implements Cloneable {
  int size;
  boolean horizontal;
  Ship(int size) {
    this.size = size;
  }
  void place(int[][] grid, int x, int y, boolean horizontal) {
    this.horizontal = horizontal;
    for (int i = 0; i < size; i++) {
      if (horizontal) {
        grid[x + i][y] = 1;
      } else {
        grid[x][y + i] = 1;
      }
    }
  }
  
  @Override
  public Ship clone() {
    return new Ship(this.size);
  }
}

// Flyweight ShipFactory class
class ShipFactory {
  HashMap<Integer, Ship> shipMap = new HashMap<>();
  
  Ship getShip(int size) {
    if (!shipMap.containsKey(size)) {
      shipMap.put(size, new Ship(size));
    }
    return shipMap.get(size).clone();
  }
}
