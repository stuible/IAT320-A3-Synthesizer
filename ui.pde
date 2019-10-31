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
  if (millis() < timeSinceDab + 1000) {
    textFont(myFont72);
    fill(200, 200, 200, 90);
    text("DAB", (width / 2) - 70, height - 100);
  }
}

void drawFilter() {
}

void drawBPM() {
}
