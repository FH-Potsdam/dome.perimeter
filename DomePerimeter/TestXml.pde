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
 * TestXml
 */
class TestXml {

  /**
   * Variables
   */
  TestObject[] testObject;


  /**
   * Constructor
   */
  TestXml() {}


  /**
   * Load a test file
   */
  void load(String file) {
    DEBUGINFO("load() file = " + file);
    
    /* Load an XML document */
    XML xml = loadXML(file);
    DEBUGINFO("xml :\n" + xml);
    
    /* Get the testSession tags */
    XML[] testSessionChildren = xml.getChildren("testSession");
    DEBUGINFO("testSessionChildren.length: "+testSessionChildren.length);
    
    //for(int i=0; i<testSessionChildren.length; i++){
      /* Get the number of <test> tags */
      XML[] testChildren = testSessionChildren[0].getChildren("test");
      DEBUGINFO("testChildren.length: "+testChildren.length);
      
      /* Set the array size of TestObject */
      testObject = new TestObject[testChildren.length];
      for (int j=0; j<testChildren.length; j++ ) {
        //DEBUGINFO("testChildren [ " + j + " ]: " + testChildren[j]);
  
        /* create child for left, middle, right tag. */
        XML leftElement = testChildren[j].getChild("left");
        XML middleElement = testChildren[j].getChild("middle");
        XML rightElement = testChildren[j].getChild("right");
        /* create arrays for src, transparency, scale and rotation. */
        String[] tempSrc = new String[3];
        tempSrc[0] =  leftElement.getString("src");
        tempSrc[1] =  middleElement.getString("src");
        tempSrc[2] =  rightElement.getString("src");
        int[] tempT = new int[3];
        tempT[0] = leftElement.getInt("transparency");
        tempT[1] = middleElement.getInt("transparency");
        tempT[2] = rightElement.getInt("transparency");
        int[] tempS = new int[3];
        tempS[0] = leftElement.getInt("scale");
        tempS[1] = middleElement.getInt("scale");
        tempS[2] = rightElement.getInt("scale");
        int[] tempR = new int[3];
        tempR[0] = leftElement.getInt("rotation");
        tempR[1] = middleElement.getInt("rotation");
        tempR[2] = rightElement.getInt("rotation");
        DEBUGINFO("testChildren [ " + j + " ] src[0]=\"" + tempSrc[0] + "\" src[1]" + tempSrc[1] + "\" src[2]" + tempSrc[2] +
        " transp[0]=\"" + tempT[0] + "\" transp[1]" + tempT[1] + "\" transp[2]" + tempT[2] + 
        " scale[0]=\"" + tempS[0] + "\" scale[1]" + tempS[1] + "\" scale[2]" + tempS[2] + 
        " rot[0]=\"" + tempR[0] + "\" rotation[1]" + tempR[1] + "\" rotation[2]" + tempR[2]);
  
        testObject[j] = new TestObject(tempSrc, tempT, tempS, tempR);
        
      } /* End for <test> */
      
    //} /* End for <testSession> */
  }
  
  
  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[TestXml] " + s);
  }
}

