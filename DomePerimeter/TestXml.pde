/**
 * TestXml
 */
class TestXml {

  /**
   * Variables
   */
  TestObject[] testObject;
  int currentTestRun = 0;


  /**
   * Constructor
   */
  TestXml() {}


  /**
   * Load a test file
   */
  void load(PApplet p, String file) {
    DEBUGINFO("load() file = " + file);
    
    // Load an XML document
    XMLElement xml = new XMLElement(p, file);
    DEBUGINFO("xml :\n" + xml);
    // get the children of teh <domePerimeter> tag
    XMLElement[] domePerimeterChildren = xml.getChildren();

    // Get all the child elements
    XMLElement[] children = domePerimeterChildren[0].getChildren();
    DEBUGINFO("children.length: "+children.length);
    // Set the array size of TestObject
    testObject = new TestObject[children.length];

    for (int i=0; i<children.length; i++ ) {
      DEBUGINFO("children: " + children[i]);

      // create child for left, middle, right tag.
      XMLElement leftElement = children[i].getChild(0);
      XMLElement middleElement = children[i].getChild(1);
      XMLElement rightElement = children[i].getChild(2);
      // create arrays for src, transparency, scale and rotation.
      String[] tempSrc = new String[3];
      tempSrc[0] =  leftElement.getStringAttribute("src");
      tempSrc[1] =  middleElement.getStringAttribute("src");
      tempSrc[2] =  rightElement.getStringAttribute("src");
      int[] tempT = new int[3];
      tempT[0] = leftElement.getIntAttribute("transparency");
      tempT[1] = middleElement.getIntAttribute("transparency");
      tempT[2] = rightElement.getIntAttribute("transparency");
      int[] tempS = new int[3];
      tempS[0] = leftElement.getIntAttribute("scale");
      tempS[1] = middleElement.getIntAttribute("scale");
      tempS[2] = rightElement.getIntAttribute("scale");
      int[] tempR = new int[3];
      tempR[0] = leftElement.getIntAttribute("rotation");
      tempR[1] = middleElement.getIntAttribute("rotation");
      tempR[2] = rightElement.getIntAttribute("rotation");

      testObject[i] = new TestObject(tempSrc, tempT, tempS, tempR);
    }
  }
  
  
  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[TestXml] " + s);
  }
}

