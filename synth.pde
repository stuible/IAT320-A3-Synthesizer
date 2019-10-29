class ToneInstrument implements Instrument
{
  // create all variables that must be used througout the class
  Oscil sineOsc;
  ADSR  adsr;
  Midi2Hz midi;

  // constructor for this instrument
  ToneInstrument( int note, float amplitude )
  {    
    //midi.setMidiNoteIn(newNote);
    
    // create new instances of any UGen objects as necessary
    sineOsc = new Oscil( 440, amplitude, Waves.SAW );
    adsr = new ADSR( 0.9, 0.01, 0.05, 0.05, 0.5 );
    
    midi = new Midi2Hz( note );
    midi.patch( sineOsc.frequency );
    
    //sineOsc.patch( moog1 ).patch( out );

    // patch everything together up to the final output
    //wave.patch( moog1 ).patch( out );
    sineOsc.patch( adsr );
    //sineOsc.patch( moog1 );
    
  }

  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    // turn on the ADSR
    adsr.noteOn();
    // patch to the output
    adsr.patch( moog1 ).patch( out );
  }

  // every instrument must have a noteOff() method
  void noteOff()
  {
    // tell the ADSR to unpatch after the release is finished
    adsr.unpatchAfterRelease( out );
    // call the noteOff 
    adsr.noteOff();
  }
}
