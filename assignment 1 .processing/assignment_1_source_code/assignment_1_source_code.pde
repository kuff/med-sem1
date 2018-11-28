float goldenRatio(float power) {
  return pow((1 + sqrt(5)) / 2, power);
} //     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ using the golden ratio for  A E S T H E T I C S

float calcPos(float formular, int span) {
  // calculate the final posisiton of the sine- or cosine functions
  return span / 2 + formular * height / 2 * goldenRatio(-1);
}

float xCalc(int divisions, int iteration, float modifier) {
  // calculate x coodinate by dividing the cosine function into intervals and adding the circle radius modifier before calculating the final position on screen using calcPos
  return calcPos(cos(((TWO_PI) / divisions) * iteration - HALF_PI) * modifier, width);
}

float yCalc(int divisions, int iteration, float modifier) {
  // calculate y coodinate by dividing the sine function into intervals and adding the circle radius modifier before calculating the final position on screen using calcPos
  return calcPos(sin(((TWO_PI) / divisions) * iteration - HALF_PI) * modifier, height);
}

void drawNumber(int a) {
  // calculate the coordinates for the clock face numbers
  float xText = xCalc(12 * 5, a, 1.1);
  float yText = yCalc(12 * 5, a, 1.1);
  // calculate what number to be painted, exchanging 0 for 12
  int number = a == 0 ? 12 : a / 5;
  // set text color and size for the clock face numbers
  fill(222, 222, 255);
  textSize(16);
  // draw the clock face numbers, adding extra x-axis offset for two digit numbers
  text(number, xText - (number > 9 ? 10 : 4), yText + 6);
}

void drawFace() {
  // draw the clock face in 60 steps for each hour and minute indicators
  for (int a = 0; a < 12 * 5; a++) {
   // calculate coordinates for the hour lines on the clock face, emphasizing the 3 hour marks
   float xStart = xCalc(12 * 5, a, 1);
   float yStart = yCalc(12 * 5, a, 1);
   float xEnd = xCalc(12 * 5, a, 0.95);
   float yEnd = yCalc(12 * 5, a, 0.95);
   if (a % 15 == 0) {
     // emphasize 3 hour markings
     xEnd = xCalc(12 * 5, a, 0.85);
     yEnd = yCalc(12 * 5, a, 0.85);
     drawNumber(a);
   }
   else if (a % 5 == 0) {
     // emphasize hour markings
     xEnd = xCalc(12 * 5, a, 0.9);
     yEnd = yCalc(12 * 5, a, 0.9);
     drawNumber(a);
    }
   // draw the calculated line
   line(xStart, yStart, xEnd, yEnd);
  }
}

void drawArms() {
  // map the 24 hours to 12 integers
  int hours = hour() <= 12 ? hour() : hour() - 12;
  // calculate the coordinates of the second-, minute-, and hour arms
  float xSeconds = xCalc(60, second(), 1);
  float ySeconds = yCalc(60, second(), 1);
  float xMinutes = xCalc(60, minute(), 0.95);
  float yMinutes = yCalc(60, minute(), 0.95);
  float xHours = xCalc(60 * 12, hours * 60 + minute(), goldenRatio(-1));
  float yHours = yCalc(60 * 12, hours * 60 + minute(), goldenRatio(-1));
  // draw the second arm in red, minute arm in green, and hour arm in blue
  stroke(255, 111, 111);
  line(xSeconds, ySeconds, width / 2, height / 2);
  stroke(111, 255, 111);
  line(xMinutes, yMinutes, width / 2, height / 2);
  stroke(111, 111, 255);
  line(xHours, yHours, width / 2, height / 2);
}

String digify(int number) {
  // add a zero to the given number if is only a single digit
  return number < 10 ? "0" + number : Integer.toString(number);
}

void drawDate() {
  // calculate coordinates for the three different complications
  float xDigital = xCalc(3, 0, goldenRatio(-2));
  float yDigital = yCalc(3, 0, goldenRatio(-2)) + 33;
  float xMillis = xCalc(3, 1, goldenRatio(-2));
  float yMillis = yCalc(3, 1, goldenRatio(-2)) + 33;
  float xDate = xCalc(3, 2, goldenRatio(-2));
  float yDate = yCalc(3, 2, goldenRatio(-2)) + 33;
  // draw the three different complications
  text(digify(hour()) + "   :   " + digify(minute()) + "   :   " + digify(second()), xDigital - 66, yDigital);
  text(digify(day()) + "   /   " + digify(month()) + "   -   " + year(), xDate - 77, yDate);
  text(millis(), xMillis, yMillis);
}

void setup () {
  // enter full screen mode for the application
  fullScreen();
}

void draw () {
  // declare background color to clear canvas and set line color to black
  background(22,22,22);
  stroke(222, 222, 255);
  // draw the clock face in 12 * 5 steps for each hour and minute indicators
  drawFace();
  // draw different complications inside the watch face
  drawDate();
  // draw the second arm in red, minute arm in green, and hour arm in blue
  drawArms();
}
