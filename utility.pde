/*  General Purpose Helper / Utility Functions */

// Returns valid but random index in an array
public static int getRandomIntegerBetweenRange(int min, int max){
    int x = (int)(Math.random()*((max-min)+1))+min;
    return x;
}

// Returns valid but random index in an array
public int getRandomIntArrayIndex(int[] myArray){
  int rand = (int)random(myArray.length);
  return rand;
}

// Return avarage of all floats in array
static final float arrayAverage(float... arr) {
  float sum = 0;
  for (float f: arr)  sum += f;
  return sum/arr.length;
}

// Return avarage of all floats in ArrayList
public float arrayListAverage(ArrayList <Float> marks) {
  Float sum = 0.0;
  if(!marks.isEmpty()) {
    for (Float mark : marks) {
        sum += mark;
    }
    return sum / marks.size();
  }
  return sum;
}
