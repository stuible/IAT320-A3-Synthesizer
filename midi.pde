int prevNote = 0;

void playRandomNote() {
  //playNote();

  int[] scale = isMajor ? major : minor;

  int newNote = scale[getRandomIntArrayIndex(scale)] + ( 12* getRandomIntegerBetweenRange(4, 5));

  //midi.setMidiNoteIn(newNote);

  if (prevNote == newNote) playRandomNote();
  else {
    out.playNote( 0, 1, new PluckInstrument( newNote, 0.25f ) );
    if (playDab){
      println("PLAY DAB");
      out.playNote( 0, 1, new PluckInstrument( newNote + 13, 1f ) );
      playDab = false;
    }
    if (playPunch){
      println("PLAY Punch");
      out.playNote( 0, 1, new PunchInstrument( newNote + 13, 1f ) );
      playPunch = false;
    }
  }
  prevNote = newNote;
}
