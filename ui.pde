/*  Functions used to draw UI */

PFont myFont72;
PFont myFont32;

void setupUI() {
  myFont72 = createFont("Futura", 72);
  myFont32 = createFont("Futura", 32);
}


void drawUI() {
  drawAction();
  drawFilter();
  drawBPM();
}

void drawAction() {
  textSize(72);
  if (millis() < timeSinceDab + 2000) {
    textFont(myFont72);
    fill(200, 200, 200, map(millis() - timeSinceDab, 500, 1300, 100, 0));
    text("DAB", (width / 2) - 70, height - 100);
  }

  if (millis() < timeSincePunch + 2000) {
    textFont(myFont72);
    fill(200, 20, 20, map(millis() - timeSincePunch, 1000, 2000, 100, 0));
    text("PUNCH", (width / 2) - 150, height - 100);
  }
}

void drawFilter() {
  textFont(myFont32);
  fill(10, 200, 40, 100);
  text(filterFreq + "Hz", 100, 250);
}

void drawBPM() {
  textFont(myFont32);
  fill(10, 200, 40, 100);
  text(BPM + " BPM", 100, 325);
}
