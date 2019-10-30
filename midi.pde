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
