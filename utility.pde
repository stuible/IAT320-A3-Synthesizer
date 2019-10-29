public static int getRandomIntegerBetweenRange(int min, int max){
    int x = (int)(Math.random()*((max-min)+1))+min;
    return x;
}

public int getRandomIntArrayIndex(int[] myArray){
  int rand = (int)random(myArray.length);
  return rand;
}
