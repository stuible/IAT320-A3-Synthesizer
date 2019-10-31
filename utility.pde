public static int getRandomIntegerBetweenRange(int min, int max){
    int x = (int)(Math.random()*((max-min)+1))+min;
    return x;
}

public int getRandomIntArrayIndex(int[] myArray){
  int rand = (int)random(myArray.length);
  return rand;
}

static final float arrayAverage(float... arr) {
  float sum = 0;
  for (float f: arr)  sum += f;
  return sum/arr.length;
}

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
