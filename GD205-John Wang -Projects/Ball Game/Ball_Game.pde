float gravity = 1;
int ballSize = 10;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
ArrayList<Ball> balls = new ArrayList<Ball>();
Client client;

void setup() {
  size(400, 600);
  //Player class handles operations regarding the ball list
  Player player = new Player();
  //Invoker executes commands
  CommandInvoker commandInvoker = new CommandInvoker();
  //client creates commands to send to the Invoker
  client = new Client(commandInvoker, player);

  // Add small obstacles in a grid pattern
  int cols = 15;
  int rows = 20;
  int spacing = 25; // Distance between obstacles

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      int obsX = i * spacing + spacing / 2;
      int obsY = j * spacing + height / 4;
      obstacles.add(new Obstacle(obsX, obsY, 10));
    }
  }
}

void draw() {
  background(255);
  drawBoard();
  
  //cycles through the balls list 
  for (Ball b : balls) {
    b.update();
    b.display();
  }
}

void drawBoard() {

  // Draw square obstacles and scoring bins
  for (Obstacle obs : obstacles) {
    obs.display();
  }
}

void mousePressed() {
    // Create and execute a new AddBallCommand through the Client
    client.addBallCommand(mouseX, mouseY);
  
}

// Command interface
interface Command {
  void execute();
}

//command for adding a ball 
class AddBallCommand implements Command {
  Player player;
  int x, y;

  AddBallCommand(Player player, int x, int y) {
    this.player = player;
    this.x = x;
    this.y = y;
  }
  public void execute() {
    player.addBall(x, y);
  }
}

// CommandInvoker to manage and execute commands 
class CommandInvoker {
  void executeCommand(Command command) {
    command.execute();
  }
}

// defines player
class Player {
  void addBall(int x, int y) {
    balls.add(new Ball(x, y));
  }
}

//client side class
class Client {
  CommandInvoker invoker; // Reference to the invoker
   Player player;  // Reference to the receiver

  // Constructor to initialize invoker and receiver
  Client(CommandInvoker invoker,Player player) {
    this.invoker = invoker;
    this.player = player;
  }
  // Method to create and send an AddBallCommand
  void addBallCommand(int x, int y) {
    Command command = new AddBallCommand(player, x, y);

    // Send the command to the invoker to be executed
    invoker.executeCommand(command);
  }
}
  
//class that stores the property of the balls
class Ball {
  int x, y, speedX, speedY;
  
  Ball(int x, int y) {
     this.x = x;
     this.y = y;
     this.speedX = int (random(-3, 3));
     this.speedY = 0;
   }
   void update() {
     speedY += gravity;
     x += speedX;
     y += speedY;
  
     if (x < 0 || x > width) speedX *= -1;
     if (y < 0 || y > height) speedY *= -1;
  
     for (Obstacle obs : obstacles) {
       if (x > obs.x && x < obs.x + obs.size && y > obs.y && y < obs.y + obs.size) {
         speedX *= -1;
         speedY *= -1;
       }
     }
   }
   
    void display() {
      fill(255, 0, 0); // Set the ball color to red
      ellipse(x, y, ballSize, ballSize);
    }
}

//stores properties of obstacles
class Obstacle {
  int x, y, size;

  Obstacle(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  void display() {
    fill(0);
    rect(x, y, size, size);
  }
}  

 
