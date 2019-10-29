import processing.serial.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
MoogFilter  moog1; 


Serial serial;

float[] magValues;
int magIndex = 0;

String prevBuffer;

boolean noBTMode = true;

boolean isMajor = false;
int noteType = 4; // 1 = Whotenote, 2 = Halfnte, 4 = Quarternote, etc
int BPM = 140;

int time;

void setup()
{
  size(512, 200, P3D);
  
  time = millis();
  
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  
  moog1    = new MoogFilter( 1200, 0.9 );  
  moog1.type = MoogFilter.Type.LP;
  
  moog1.patch( out );
  
  try {
    //println(Serial.list()); 
    serial = new Serial(this, Serial.list()[1], 38400);
    println("OPENING PORT");
    //s.write('0');
  }
  catch(Exception e) {
    println("PORT NOT AVAILABLE");
  }

  
  magValues = new float[10];
  
  prevBuffer = "";
}

void draw()
{
  background(0);
  stroke(255);
  strokeWeight(1);
  
  // draw the waveform of the output
  for(int i = 0; i < out.bufferSize() - 1; i++)
  {
    line( i, 50  - out.left.get(i)*50,  i+1, 50  - out.left.get(i+1)*50 );
    line( i, 150 - out.right.get(i)*50, i+1, 150 - out.right.get(i+1)*50 );
  }
  
  // Triger new note based on BPM and note type
  if (millis() > time + ((60000 / (BPM / 2)) / noteType))
  {
    playRandomNote();
    time = millis();
  }
  
  
  
  if(serial != null){
    while (serial.available() > 0) {
    String inBuffer = serial.readString();   
    if (inBuffer != null) {
       //println("here is the buffer:");
      //println(inBuffer);

      
      try {
        float magVal = Float.parseFloat(prevBuffer + inBuffer);
        
        magValues[magIndex] = magVal;
        if(magIndex >= 9) magIndex = 0;
        else magIndex++;
        
        float avg = arrayAverage(magValues);
        float filterFreq = constrain(map(avg, -70, 300, 10, 5000 ), 10, 5000);
        moog1.frequency.setLastValue(filterFreq);
        
        ////print("Mag Val");
        println(magVal);
        //print("Mag AVG");
        //println(avg);
        
      } catch (NumberFormatException e) {

      }
      
      
      //int magVal = Integer.parseInt(inBuffer);
      //println(magVal);
      
      prevBuffer = inBuffer;
      
      if(inBuffer.endsWith("\n")){
         //print("Broken: '");
         //println(inBuffer + "'");
         prevBuffer = "";
      }
      else {
        //print("Valid: '");
        // println(inBuffer + "'");
        prevBuffer = inBuffer;
      }
    }
  }
  }
  
  
}

void mouseMoved()
{
  // usually when setting the amplitude and frequency of an Oscil
  // you will want to patch something to the amplitude and frequency inputs
  // but this is a quick and easy way to turn the screen into
  // an x-y control for them.
  
  //float amp = map( mouseY, 0, height, 1, 0 );
  
  float filterFreq = map( mouseY, 0, height, 10, 5000 );
  if(noBTMode) moog1.frequency.setLastValue(filterFreq);
  
  //float freq = map( mouseX, 0, width, 40, 880 );
}
