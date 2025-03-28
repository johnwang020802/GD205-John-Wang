//Maintains two buffers, current Buffer, and next buffer;
//CurrentBuffer: Contains the graphics data that is actively displayed on the screen.
//NextBuffer: Used to render new graphics off-screen, ensuring updates happen smoothly. 
//The buffers are swapped using the swapBuffer method, ensuring a seamless transition between frames.

class BufferManager {
  PGraphics currentBuffer;
  PGraphics nextBuffer;

  BufferManager(int width, int height) {
    currentBuffer = createGraphics(width, height);
    nextBuffer = createGraphics(width, height);
  }

  PGraphics getCurrentBuffer() {
    return currentBuffer;
  }

  PGraphics getNextBuffer() {
    return nextBuffer;
  }

  void swapBuffers() {
    PGraphics temp = currentBuffer;
    currentBuffer = nextBuffer;
    nextBuffer = temp;
  }
}
