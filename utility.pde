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
