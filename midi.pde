/* Main Note Play Function */

int prevNote = 0;

void playRandomNote() {

  int[] scale = isMajor ? major : minor;

  // Get random note form scale array
  int newNote = scale[getRandomIntArrayIndex(scale)] + ( 12* getRandomIntegerBetweenRange(4, 5));

  // Prevents system from playing the same note twice (Because that's boring)
  if (prevNote == newNote) playRandomNote();
  else {
    out.playNote( 0, 1, new PluckInstrument( newNote, 0.25f ) );
    
    // If dab note needs to be played, then do it
    if (playDab){
      println("PLAY DAB");
      out.playNote( 0, 1, new PluckInstrument( newNote + 13, 1f ) );
      playDab = false;
    }
    // If punch note needs to be played, then do it
    if (playPunch){
      println("PLAY Punch");
      out.playNote( 0, 10, new PunchInstrument( newNote - 12, 1f ) );
      playPunch = false;
    }
  }
  prevNote = newNote;
}
