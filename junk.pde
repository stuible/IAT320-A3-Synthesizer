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
    //  wave.setWaveform( Waves.QUARTERPULSE );
    //  break;
     
    default: break; 
  }
}


void dontneed(){
  //if(serial != null){
  //  while (serial.available() > 0) {
  //  String inBuffer = serial.readString();   
  //  if (inBuffer != null) {
  //     //println("here is the buffer:");
  //    //println(inBuffer);

      
  //    try {
  //      float magVal = Float.parseFloat(prevBuffer + inBuffer);
        
  //      magValues[magIndex] = magVal;
  //      if(magIndex >= 9) magIndex = 0;
  //      else magIndex++;
        
  //      float avg = arrayAverage(magValues);
  //      float filterFreq = constrain(map(avg, -70, 300, 10, 5000 ), 10, 5000);
  //      moog1.frequency.setLastValue(filterFreq);
        
  //      ////print("Mag Val");
  //      println(magVal);
  //      //print("Mag AVG");
  //      //println(avg);
        
  //    } catch (NumberFormatException e) {

  //    }
      
      
  //    //int magVal = Integer.parseInt(inBuffer);
  //    //println(magVal);
      
  //    prevBuffer = inBuffer;
      
  //    if(inBuffer.endsWith("\n")){
  //       //print("Broken: '");
  //       //println(inBuffer + "'");
  //       prevBuffer = "";
  //    }
  //    else {
  //      //print("Valid: '");
  //      // println(inBuffer + "'");
  //      prevBuffer = inBuffer;
  //    }
  //  }
  //}
  //}
  
}
