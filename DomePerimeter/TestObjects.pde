/**
 * dome.perimeter is released under the MIT License.
 *
 * Copyright (c) 2012-2013, Paul Vollmer http://www.wrong-entertainment.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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

