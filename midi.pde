//void playNote(int note)
//{
 
 
 
// float freq1 = map(note, 0, 98, 110, 880);  //mapping the notes-values to the frequency-spectrum
//  wave.setFrequency( freq1 );
 
//}

int prevNote = 0;

void playRandomNote(){
  //playNote();
  
  int newNote = major[getRandomIntArrayIndex(minor)] + ( 12* getRandomIntegerBetweenRange(4, 5));
  
  out.playNote( 1, 1, new ToneInstrument( newNote, 0.07 ) );
  
  //midi.setMidiNoteIn(newNote);
  
  if(prevNote == newNote) playRandomNote();
  
  prevNote = newNote;
}
