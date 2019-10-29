//void playNote(int note)
//{
 
 
 
// float freq1 = map(note, 0, 98, 110, 880);  //mapping the notes-values to the frequency-spectrum
//  wave.setFrequency( freq1 );
 
//}

int prevNote = 0;

void playRandomNote(){
  //playNote();
  
  int[] scale = isMajor ? major : minor;
  
  int newNote = scale[getRandomIntArrayIndex(scale)] + ( 12* getRandomIntegerBetweenRange(4, 5));
  
  
  
  //midi.setMidiNoteIn(newNote);
  
  if(prevNote == newNote) playRandomNote();
  else out.playNote( 1, 1, new ToneInstrument( newNote, 0.5f ) );
  
  prevNote = newNote;
}
