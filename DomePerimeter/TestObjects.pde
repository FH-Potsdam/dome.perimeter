/**
 * TestObject
 */
class TestObject {

  // Create 3 TestFile objects for left, middle and right file.
  TestGraphic[] testGraphic = new TestGraphic[3];


  /**
   * Constructor
   *
   * @param src
   * @param transparency
   * @param scale
   * @param rotation
   */
  TestObject(String[] src, int[] transparency, int[] scale, int[] rotation) {
    testGraphic[0] = new TestGraphic(src[0], transparency[0], scale[0], rotation[0]);
    testGraphic[1] = new TestGraphic(src[1], transparency[1], scale[1], rotation[1]);
    testGraphic[2] = new TestGraphic(src[2], transparency[2], scale[2], rotation[2]);
  }


  /**
   * display
   *
   * @param latitude
   */
  void display(int latitude) {    
    float tempPos = map(latitude, 90, 0, 0, width/2);
    //println("tempPos: " + tempPos);

    testGraphic[0].display((int)tempPos, -HALF_PI);
    testGraphic[1].display((int)tempPos, 0);
    testGraphic[2].display((int)tempPos, HALF_PI);
  }
}

