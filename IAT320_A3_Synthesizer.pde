import processing.serial.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

// Global Vars
Minim       minim;
AudioOutput out;
MoogFilter  moog1; 

Serial serial;

String serialBuffer;

boolean noBTMode = true;

boolean isMajor = false;
int noteType = 8; // 1 = Whotenote, 2 = Halfnte, 4 = Quarternote, etc
float BPM = 120;

float targetBPM = BPM;

float filterFreq;

boolean playDab = false;
boolean playPunch = false;

int timeSinceLastMovement = 0;

int timeSinceRemovedMovement = 0;

int timeSinceDab = 0;
int timeSincePunch = 0;


ArrayList<Float>  movementArray = new ArrayList<Float>();  

int time;

void setup()
{
  // Setup window & UI
  size(1000, 750, P3D);
  setupUI();

  // Instantiate time variable with current millis
  time = millis();

  // Instantiate the minim audio library
  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();

  // Instantiate lowpass filter
  moog1 = new MoogFilter( 1200, 0.9 );  
  moog1.type = MoogFilter.Type.LP;
  moog1.patch( out );

  // Open bluetooth serial connection
  try {
    //println(Serial.list()); 
    serial = new Serial(this, Serial.list()[1], 9600);
    println("OPENING PORT");
    //s.write('0');
  }
  catch(Exception e) {
    println("PORT NOT AVAILABLE");
  }

  // Instantiate serial buffer string
  serialBuffer = "";
}

void draw()
{
  // Draw UI
  background(0);
  stroke(255);
  strokeWeight(1);
  drawUI();

  // draw the waveform of the output
  for (int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, 50  - out.left.get(i)*50, i+1, 50  - out.left.get(i+1)*50 );
    line( i, 150 - out.right.get(i)*50, i+1, 150 - out.right.get(i+1)*50 );
  }

  // Triger new note based on BPM and note type
  if (millis() > time + ((60000 / (BPM / 2)) / noteType))
  {
    playRandomNote();
    time = millis();
  }

  //Slow down BPM to idle tempo if there hasn't been movement for 5 seconds
  if (millis() > timeSinceLastMovement + 5000)  targetBPM = 100;

  if (millis() > timeSinceRemovedMovement + 1000) {
    if (movementArray.size() != 0) movementArray.remove(0);
    timeSinceRemovedMovement = millis();
    println(movementArray.size());
  }

  // Map size of movement array to filter cutoff frequency
  filterFreq = map( movementArray.size(), 0, 30, 10, 5000 );
  moog1.frequency.setLastValue(filterFreq);

  // If current BPM is not the same as TargetBPM increment it in the right direction
  // This smoothly transitions between tempos without being too jarring
  if (BPM != targetBPM) {
    if (targetBPM > BPM) BPM += 0.5;
    else if (targetBPM < BPM) BPM -= 0.25;
    println("Changed BPM: " + BPM);
    println("Taget BPM: " + targetBPM);
  }


  // Pulls serial data into buffer if available.
  if (serial != null) {
    while (serial.available() > 0) {
      String inBuffer = serial.readString();   
      if (inBuffer != null) {
        //println("here is the buffer:");
        //println(inBuffer);

        serialBuffer += inBuffer;

        //Recived completed json object and can now process it
        if (serialBuffer.endsWith("\n")) {
          //print(serialBuffer);

          // Confirm we started listening in time to recieve the beginning of the JSON object
          JSONObject json = serialBuffer.startsWith("{") ? parseJSONObject(serialBuffer) : null;
          if (json == null) {
            println("JSONObject could not be parsed");
          } else {
            println(serialBuffer);

            // Process general movement data if it exists in json object
            if (json.hasKey("gMov")) {
              float gMov = json.getFloat("gMov");
              println(gMov);
              movementArray.add(gMov);

              targetBPM = (int) map(arrayListAverage(movementArray), 0, 10, 70, 200);

              timeSinceLastMovement = millis();
            }

            // Process Gesture if it exists in json object
            if (json.hasKey("action")) {
              String action = json.getString("action");

              if (action.equals("dab")) {
                playDab = true;
                timeSinceDab = millis();
              }
              if (action.equals("punch")) {
                playPunch = true;
                timeSincePunch = millis();
              }
            }
          }

          //Reset buffer
          serialBuffer = "";
        } else {
          //println("Buffer not ready:");
          //println(serialBuffer);
        }
      }
    }
  }
}
