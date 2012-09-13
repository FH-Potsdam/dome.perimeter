/**
 * TestObject
 */
class TestObject {

  // Create 3 TestFile objects for left, middle and right file.
  TestFile[] testFile = new TestFile[3];


  /**
   * Constructor
   *
   * @param src
   * @param transparency
   * @param scale
   * @param rotation
   */
  TestObject(String[] src, int[] transparency, int[] scale, int[] rotation){
    testFile[0] = new TestFile(src[0], transparency[0], scale[0], rotation[0]);
    testFile[1] = new TestFile(src[1], transparency[1], scale[1], rotation[1]);
    testFile[2] = new TestFile(src[2], transparency[2], scale[2], rotation[2]);
  }
  
  
  /**
   * display
   *
   * @param latitude
   */
  void display(int latitude){    
    float tempPos = map(latitude, 90, 0, 0, width/2);
    //println("tempPos: " + tempPos);
    
    testFile[0].display((int)tempPos, -HALF_PI);
    testFile[1].display((int)tempPos, 0);
    testFile[2].display((int)tempPos, HALF_PI);
  }
  
}

