VotingBooth booth; // declare the variable containing the voting booth
ArrayList<Button> buttons; // declare a list of buttons (ArrayList is a class wrapper for the default list) 

void setup() {
  // initialize the list of buttons as well as the five voting buttons
  noStroke();
  background(200, 200, 200);
  size(800, 800);
  booth = new VotingBooth();
  buttons = new ArrayList<Button>(5);
  buttons.add(new Button(100, 100, 250, 200, 1, '1'));
  buttons.add(new Button(300, 100, 450, 200, 2, '2'));
  buttons.add(new Button(500, 100, 650, 200, 3, '3'));
  buttons.add(new Button(100, 250, 250, 350, 4, '4'));
  buttons.add(new Button(500, 250, 650, 350, 5, '5'));
}

void draw() {
  for (Button b : buttons) b.updateMouse(); // update the mouse position in order to hightlight buttons if hovering over them
  if (!booth.voteIsDone) {
    // draw the buttons and the progress bar if the vote is still active
    for (Button b : buttons) b.render();
    drawProgressBar(); // (progress bar also draws the guiding text)
  }
  else {
    // if the vote is closed, draw the results
    drawResults();
  }
}

void mousePressed() {
  // react on the press of a mouse button and push the event to the buttons
  for (Button b : buttons) b.click();
}

void keyPressed() {
  // react to the press of a key
  if (key == 'r') {
    // if the user presses "r", reset the vote
    booth.reset();
    background(200, 200, 200);
  }
  // if the user presses "ENTER" and one or more votes have already been cast, close the vote
  else if (key == ENTER && booth.votes.size() > 0) booth.voteIsDone = true;
  // if the key pressed is neither "r" or "ENTER", push the event on to the buttons
  else for (Button b : buttons) b.press();
}

void drawProgressBar() {
  // draw the progress bar
  noStroke();
  fill(70, 120, 255);
  rect(0, height - 30, (width / 10) * booth.votes.size(), 30);
  // draw the guiding text
  textSize(16);
  fill(0);
  text("click on the buttons or use the number keys to cast a vote!", 160, 500);
  // draw the additional helping text when at least one vote has been recieved
  if (booth.votes.size() > 0) {
    fill(70, 120, 255);
    textSize(12);
    text("click ENTER to continue!", 300, 560); 
  }
}

float calcY(int number) {
  // calculate the y-coordinates when split into 10 steps (only used in "drawResults")
  return ((height - 100) / 10) * number;
}

void drawResults() {
  // clear the canvas
  background(200, 200, 200);
  // draw the guiding text at the top
  text(booth.votes.size() + (booth.votes.size() == 1 ? " vote" : " votes") + " in total.", 290, 30);
  fill(70, 120, 255); //    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ account for plural "s" with in-line if statement
  text("Press R to start over!", 395, 30);
  
  // draw the plots and the bar chart
  for (int i = 0; i < 10; i++) {
    // calculate the positions of the vertical lines
    float y = calcY(i);
    float x = y * 2 + 140;
    // draw the lines on the y-axis
    fill(0);
    stroke(0);
    line(50, 50 + y, 60, 50 + y);
    // draw the numbers on the y-axis
    textSize(12);
    text(10 - i, 10 - i == 10 ? 28 : 35, 55 + y);
    //                ^^^^^^^^^^^^^^^^^ account for 10 with in-line if statement
    
    if (i < 5) {
      // draw the numbers on the x-axis
      textSize(16);
      text(i + 1, x, height - 30);
      // count the amount of votes for i
      int count = 0;
      for (int vote : booth.votes) if (vote == i + 1) count++;
      // draw the actual bars if one or more votes were cast
      fill(70, 120, (255 / 10) * (count + 1));
      noStroke();
      if (count > 0) rect(x - 44, calcY(10 - count) + 50, 96, calcY(count));
    }
    
  }
  
}
