class Button {
  
  private int x1, y1, x2, y2; // the coordiantes of the button
  private int buttonColor; // the color of the button
  private int number; // the number that the button will vote for
  private char keyToPress; // the key that the button will react on
  //^^^^^ "private" means the object property won't be acceptable outside of the class (button.keyToPress won't work)
  
  Button(int x1, int y1, int x2, int y2, int number, char keyToPress) {
    // the constructor, initializing all properties of the button
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.buttonColor = 0;
    this.number = number;
    this.keyToPress = keyToPress;
  }
  
  private boolean mouseOver() {
    // returns a boolean value depending on whether or not the mouse position is within the rectangle of the button
    return mouseX > this.x1 && mouseX < this.x2 && mouseY > this.y1 && mouseY < this.y2;
  }
  
  void updateMouse() {
    // changes the color of the button to act as a mouse-over highlight
    if (mouseOver()) this.buttonColor = 80;
    else this.buttonColor = 0;
  }
  
  void click() {
    // called when all buttons are clicked, then checks mouse position to determine if this specific button was clicked. If so, add a vote
    if (mouseOver()) booth.vote(this.number);
  }
  
  void press() {
    // called when any key is pressed, then checks if the key pressed matches this specific button. If so, add a vote.
    if (key == keyToPress) booth.vote(this.number);
  }
  
  void render() { // fancy word for draw...
    // draw the rectangle as well as the color and the text
    fill(this.buttonColor);
    noStroke();
    rect(this.x1, this.y1, this.x2 - this.x1, this.y2 - this.y1);
    fill(255);
    textSize(30);
    text("Vote " + number, this.x1 + 30, this.y1 + 60);
  }
  
}
