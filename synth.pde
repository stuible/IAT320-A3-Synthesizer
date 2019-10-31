class PluckInstrument implements Instrument
{
  // create all variables that must be used througout the class
  Oscil sineOsc;
  ADSR  adsr;
  Midi2Hz midi;

  // constructor for this instrument
  PluckInstrument( int note, float amplitude )
  {    
    //println("instantiating note");

    // create new instances of any UGen objects as necessary
    sineOsc = new Oscil( 440, amplitude, Waves.SAW );
    adsr = new ADSR( 0.9, 0.01, 0.05, 0.05, 0.5 );
    
    midi = new Midi2Hz( note );
    midi.patch( sineOsc.frequency );
    
    sineOsc.patch( adsr );
    
    //println("FINISHED instantiating note");
    
  }

  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    println("about to send out note");
    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( moog1 );
    println("DONE send out note");
  }

  // every instrument must have a noteOff() method
  void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease( moog1 );
    // call the noteOff 
    adsr.noteOff();
  }
}

class PunchInstrument implements Instrument
{
  // create all variables that must be used througout the class
  Oscil sineOsc;
  ADSR  adsr;
  Midi2Hz midi;

  // constructor for this instrument
  PunchInstrument( int note, float amplitude )
  {    
    //println("instantiating note");

    // create new instances of any UGen objects as necessary
    sineOsc = new Oscil( 440, amplitude, Waves.SAW );
    adsr = new ADSR( 0.9, 0.5, 0.05, 0.05, 0.5 );
    
    midi = new Midi2Hz( note );
    midi.patch( sineOsc.frequency );
    
    sineOsc.patch( adsr );
    
    //println("FINISHED instantiating note");
    
  }

  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    println("about to send out note");
    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( moog1 );
    println("DONE send out note");
  }

  // every instrument must have a noteOff() method
  void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease( moog1 );
    // call the noteOff 
    adsr.noteOff();
  }
}
