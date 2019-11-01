import processing.serial.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
MoogFilter  moog1; 

Serial serial;

float[] magValues;
int magIndex = 0;

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
  size(1000, 750, P3D);
  setupUI();

  time = millis();

  minim = new Minim(this);

  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();


  moog1    = new MoogFilter( 1200, 0.9 );  
  moog1.type = MoogFilter.Type.LP;

  moog1.patch( out );

  try {
    //println(Serial.list()); 
    serial = new Serial(this, Serial.list()[1], 9600);
    println("OPENING PORT");
    //s.write('0');
  }
  catch(Exception e) {
    println("PORT NOT AVAILABLE");
  }


  magValues = new float[10];

  serialBuffer = "";
}

void draw()
{
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

  filterFreq = map( movementArray.size(), 0, 30, 10, 5000 );
  moog1.frequency.setLastValue(filterFreq);

  if (BPM != targetBPM) {
    if (targetBPM > BPM) BPM += 0.5;
    else if (targetBPM < BPM) BPM -= 0.25;
    println("Changed BPM: " + BPM);
    println("Taget BPM: " + targetBPM);
  }



  if (serial != null) {
    while (serial.available() > 0) {
      String inBuffer = serial.readString();   
      if (inBuffer != null) {
        //println("here is the buffer:");
        //println(inBuffer);

        serialBuffer += inBuffer;

        //Recived completed json object
        if (serialBuffer.endsWith("\n")) {
          //print(serialBuffer);

          JSONObject json = serialBuffer.startsWith("{") ? parseJSONObject(serialBuffer) : null;
          if (json == null) {
            println("JSONObject could not be parsed");
          } else {
            println(serialBuffer);

            if (json.hasKey("gMov")) {
              float gMov = json.getFloat("gMov");
              println(gMov);
              movementArray.add(gMov);

              targetBPM = (int) map(arrayListAverage(movementArray), 0, 10, 70, 200);

              timeSinceLastMovement = millis();
            }

            if (json.hasKey("action")) {
              String action = json.getString("action");
             
              if (action.equals("dab")){
                playDab = true;
                timeSinceDab = millis();
              }
              if (action.equals("punch")){
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
