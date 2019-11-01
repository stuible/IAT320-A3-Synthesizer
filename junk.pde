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
     
    default: break; 
  }
}
