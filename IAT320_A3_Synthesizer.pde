import processing.serial.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

Minim       minim;
AudioOutput out;
Oscil       wave;
MoogFilter  moog1; 


Serial serial;

float[] magValues;
int magIndex = 0;

String prevBuffer;

boolean noBTMode = true;

int time;

void setup()
{
  size(512, 200, P3D);
  
  time = millis();
  
  minim = new Minim(this);
  
  // use the getLineOut method of the Minim object to get an AudioOutput object
  out = minim.getLineOut();
  
  // create a sine wave Oscil, set to 440 Hz, at 0.5 amplitude
  //wave = new Oscil( 440, 0.5f, Waves.SINE );
  // patch the Oscil to the output
  
  moog1    = new MoogFilter( 1200, 0.9 );  
  moog1.type = MoogFilter.Type.LP;
  
  // make our midi converter
  //midi = new Midi2Hz( 50 );
  //midi.patch( wave.frequency );
  
  //wave.patch( moog1 ).patch( out );
  
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

  // draw the waveform we are using in the oscillator
  //stroke( 128, 0, 0 );
  //strokeWeight(4);
  //for( int i = 0; i < width-1; ++i )
  //{
  //  point( i, height/2 - (height*0.49) * wave.getWaveform().value( (float)i / width ) );
  //}
  
  
  if (millis() > time + 125)
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
  //wave.setAmplitude( amp );
  
  float filterFreq = map( mouseY, 0, height, 10, 5000 );
  if(noBTMode) moog1.frequency.setLastValue(filterFreq);
  
  //float freq = map( mouseX, 0, width, 40, 880 );
  //if(noBTMode) wave.setFrequency( freq );
}

static final float arrayAverage(float... arr) {
  float sum = 0;
  for (float f: arr)  sum += f;
  return sum/arr.length;
}
