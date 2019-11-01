/* Just for fun key change functionality */

void keyPressed()
{ 
  switch( key )
  {
    
    case '1': 
      isMajor = true;
      break;
    case '2': 
      isMajor = false;
      break;
    //case '1': 
    //  wave.setWaveform( Waves.SINE );
    //  break;
     
    //case '2':
    //  wave.setWaveform( Waves.TRIANGLE );
    //  break;
     
    //case '3':
    //  wave.setWaveform( Waves.SAW );
    //  break;
    
    //case '4':
    //  wave.setWaveform( Waves.SQUARE );
    //  break;
      
    //case '5':
    //  out.playNote( 1, 1, new ToneInstrument( 60, 0.25f ) );
    //  break;
     
    default: break; 
  }
}

//Previously used mouseMove mapping for filter debugging
//void mouseMoved()
//{

//  //float amp = map( mouseY, 0, height, 1, 0 );

//  float filterFreq = map( mouseY, 0, height, 10, 5000 );
//  if (noBTMode) moog1.frequency.setLastValue(filterFreq);

//  //float freq = map( mouseX, 0, width, 40, 880 );
//}
