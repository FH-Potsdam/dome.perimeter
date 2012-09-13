/**
 * GUI
 */
class GUI {

  /**
   * Variables
   */
  ControlP5 controlP5;

  /**
   * Constructor
   */
  GUI() {}


  /**
   * setup
   */
  void setup(PApplet p) {
    DEBUGINFO("setup()");

    // Set up the GUI elements
    // for this we need slider and buttons.
    controlP5 = new ControlP5(p);
    
    // Background RGB
    controlP5.addSlider("BG R", 0,255,appSettingsXml.backgroundColor[0], 10,30, 100,14).setId(10);
    controlP5.addSlider("BG G", 0,255,appSettingsXml.backgroundColor[1], 10,50, 100,14).setId(11);
    controlP5.addSlider("BG B", 0,255,appSettingsXml.backgroundColor[2], 10,70, 100,14).setId(12);
    
    // Dome Grid
    controlP5.addToggle("DOMEGRID", appSettingsXml.domegridDisplay, 10,90, 14,14).setId(20);
    
    // TEST PARAMETER
    controlP5.addSlider("TRANSPARENCY", 0,255,testXml.testObject[0].testGraphic[0].transparency, 10,height-120, 100,14).setId(30);
    controlP5.addSlider("SCALE", 0,255,testXml.testObject[0].testGraphic[0].scale, 10,height-100, 100,14).setId(31);
    controlP5.addSlider("ROTATE_LEFT", -180,180,testXml.testObject[0].testGraphic[0].rotation, 10,height-80, 100,14).setId(320);
    controlP5.addSlider("ROTATE_MIDDLE", -180,180,testXml.testObject[0].testGraphic[1].rotation, 10,height-60, 100,14).setId(321);
    controlP5.addSlider("ROTATE_RIGHT", -180,180,testXml.testObject[0].testGraphic[2].rotation, 10,height-40, 100,14).setId(322);
    controlP5.addSlider("LATITUDE_DEGREE", 0,90,appSettingsXml.latitudeDegree, 10,height-20, 100,14).setId(33);
    
    // Test
    controlP5.addButton("PREV", 0, width-120,height-30, 50,14).setId(40);
    controlP5.addButton("NEXT", 0, width-60,height-30, 50,14).setId(41);
  }


  /**
   * setControllerValue
   */
  void setControllerValue() {
    DEBUGINFO("setControllerValue()");
    
    controlP5.controller("TRANSPARENCY").setValue(testXml.testObject[testXml.currentTestRun].testGraphic[0].transparency);
    controlP5.controller("SCALE").setValue(testXml.testObject[testXml.currentTestRun].testGraphic[0].scale);
    controlP5.controller("ROTATE_LEFT").setValue(testXml.testObject[testXml.currentTestRun].testGraphic[0].rotation);
    controlP5.controller("ROTATE_MIDDLE").setValue(testXml.testObject[testXml.currentTestRun].testGraphic[1].rotation);
    controlP5.controller("ROTATE_RIGHT").setValue(testXml.testObject[testXml.currentTestRun].testGraphic[2].rotation);
  }
  
  
  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[GUI] " + s);
  }
}

