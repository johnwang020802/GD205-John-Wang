// Flyweight cell class
class Cell {
  color fillColor;
  
  Cell(color c) {
    fillColor = c;
  }
  
  void draw(float x, float y, float size) {
    fill(fillColor);
    rect(x, y, size, size);
    fill(0);
  }
}

class CellFactory {
  HashMap<Integer, Cell> cellMap = new HashMap<>();
  
  //determine cell color based on hashmap state
  Cell getCell(int state) {
    if (!cellMap.containsKey(state)) {
      color c;
      if (state == 1) {
        c = color(255); // Ship part (masked as empty)
      } else if (state == 2) {
        c = color(255, 0, 0); // Hit
      } else if (state == 3) {
        c = color(0, 0, 255); // Miss
      } else {
        c = color(255); // Empty or unguessed
      }
      cellMap.put(state, new Cell(c));
    }
    return cellMap.get(state);
  }
}
