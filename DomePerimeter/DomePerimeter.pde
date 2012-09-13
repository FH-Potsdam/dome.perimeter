/**
 * Dome.Perimeter is developed by Prof. Dufke
 * Code by Paul Vollmer <paul.vollmer@fh-potsdam.de>
 * 
 * FH-Potsdam
 * University of Applied Science
 *
 * 
 * @processing-version   1.2.1
 * @author               Paul Vollmer
 * @modified             2012.09.13
 * @version              0.1.4d
 */



import processing.opengl.*;
import processing.xml.*;
import controlP5.*;
ControlP5 controlP5;

// The Application Settings managed by appSettingsXml class.
AppSettingsXml appSettingsXml;

PFont font;

PImage domegrid;

TestObject[] testObject;
int currentTestRun = 0;



/**
 * Processing main setup
 */
void setup(){
  // Load the application settings  
  appSettingsXml = new AppSettingsXml();
  appSettingsXml.read(this, "appSettings.xml");
  appSettingsXml.setup();
  
  // load a font for informations and other text stuff
  font = loadFont("font/Unibody8-Regular.vlw");
  
  
  // Load an XML document
  XMLElement xml = new XMLElement(this, appSettingsXml.tempTestFilename);
  println("xml :\n" + xml);
  // get the children of teh <domePerimeter> tag
  XMLElement[] domePerimeterChildren = xml.getChildren();
  
  // Get all the child elements
  XMLElement[] children = domePerimeterChildren[0].getChildren();
  println("children.length: "+children.length);
  // Set the array size of TestObject
  testObject = new TestObject[children.length];
  
  for (int i=0; i<children.length; i++ ) {
    //println("children: " + children[i]);
    
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
  
  
  // Set up the GUI elements
  // for this we need slider and buttons.
  controlP5 = new ControlP5(this);
  // Background RGB
  controlP5.addSlider("BG R", 0,255,appSettingsXml.backgroundColor[0], 10,30, 100,14).setId(10);
  controlP5.addSlider("BG G", 0,255,appSettingsXml.backgroundColor[1], 10,50, 100,14).setId(11);
  controlP5.addSlider("BG B", 0,255,appSettingsXml.backgroundColor[2], 10,70, 100,14).setId(12);
  // Dome Grid
  controlP5.addToggle("DOMEGRID", appSettingsXml.domegridDisplay, 10,90, 14,14).setId(20);
  // TEST PARAMETER
  controlP5.addSlider("TRANSPARENCY", 0,255,testObject[0].testFile[0].transparency, 10,height-120, 100,14).setId(30);
  controlP5.addSlider("SCALE", 0,255,testObject[0].testFile[0].scale, 10,height-100, 100,14).setId(31);
  controlP5.addSlider("ROTATE_LEFT", -180,180,testObject[0].testFile[0].rotation, 10,height-80, 100,14).setId(320);
  controlP5.addSlider("ROTATE_MIDDLE", -180,180,testObject[0].testFile[1].rotation, 10,height-60, 100,14).setId(321);
  controlP5.addSlider("ROTATE_RIGHT", -180,180,testObject[0].testFile[2].rotation, 10,height-40, 100,14).setId(322);
  controlP5.addSlider("LATITUDE_DEGREE", 0,90,appSettingsXml.latitudeDegree, 10,height-20, 100,14).setId(33);
  // Test
  controlP5.addButton("PREV", 0, width-120,height-30, 50,14).setId(40);
  controlP5.addButton("NEXT", 0, width-60,height-30, 50,14).setId(41);
  
  
  // load the domegrid image
  domegrid = loadImage("domegrid/domegrid.png");
}




/**
 * Processing main draw
 */
void draw(){
  background(20);
  if(appSettingsXml.domegridDisplay == true) {
    tint(appSettingsXml.backgroundColor[0], appSettingsXml.backgroundColor[1], appSettingsXml.backgroundColor[2]);
    image(domegrid, 0, 0, width, height);
    noTint();
  } else {
    fill(appSettingsXml.backgroundColor[0], appSettingsXml.backgroundColor[1], appSettingsXml.backgroundColor[2]);
    ellipse(width/2, height/2, width, height);
  }
  
  // Typo für gui beschreibung, test ergebniss etc.
  fill(255);
  textFont(font);
  text("BACKGROUND COLOR:", 10, 20);
  text("TEST PARAMETER:", 10, height-130);
  text("FrameRate: "+(int)frameRate+"\nFrameCount: "+frameCount, width-120, 20);
  text("TEST-RUN NO: "+currentTestRun, width-120, height-40);
  
  testObject[currentTestRun].display(appSettingsXml.latitudeDegree);
}




/**
 * controlP5 Events
 */
public void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.controller().id());
  
  switch(theEvent.controller().id()){
    // Object RGB
    case(30):
      testObject[currentTestRun].testFile[0].transparency = (int)(theEvent.controller().value());
      testObject[currentTestRun].testFile[1].transparency = (int)(theEvent.controller().value());
      testObject[currentTestRun].testFile[2].transparency = (int)(theEvent.controller().value());
      break;
    case(31):
      testObject[currentTestRun].testFile[0].scale = (int)(theEvent.controller().value());
      testObject[currentTestRun].testFile[1].scale = (int)(theEvent.controller().value());
      testObject[currentTestRun].testFile[2].scale = (int)(theEvent.controller().value());
      break;
    case(320):
      testObject[currentTestRun].testFile[0].rotation = (int)(theEvent.controller().value());
      break;
    case(321):
      testObject[currentTestRun].testFile[1].rotation = (int)(theEvent.controller().value());
      break;
    case(322):
      testObject[currentTestRun].testFile[2].rotation = (int)(theEvent.controller().value());
      break;
    case(33):
      appSettingsXml.latitudeDegree = (int)(theEvent.controller().value());
      break;
    
    // BG Transparency, Scale, Rotation
    case(10):
      appSettingsXml.backgroundColor[0] = (int)(theEvent.controller().value());
      break;
    case(11):
      appSettingsXml.backgroundColor[1] = (int)(theEvent.controller().value());
      break;
    case(12):
      appSettingsXml.backgroundColor[2] = (int)(theEvent.controller().value());
      break;
    
    // Domwrid display  
    case(20):
      int tempVar;
      tempVar = (int)(theEvent.controller().value());
      //println(tempVar);
      if(tempVar == 0) appSettingsXml.domegridDisplay = false;
      else appSettingsXml.domegridDisplay = true;
      break;
    
    // PREV
    case(40):
      if(currentTestRun <= 0) {
        println(currentTestRun);
      } else {
        currentTestRun--;
        setControllerValue();
        println(currentTestRun);
      }
      break;
    
    // NEXT
    case(41):
      if(currentTestRun >= testObject.length-1) {
        println(currentTestRun);
      } else {
        currentTestRun++;
        setControllerValue();
        println(currentTestRun);
      }
      break;
  }
}



void setControllerValue(){
  controlP5.controller("TRANSPARENCY").setValue(testObject[currentTestRun].testFile[0].transparency);
  controlP5.controller("SCALE").setValue(testObject[currentTestRun].testFile[0].scale);
  controlP5.controller("ROTATE_LEFT").setValue(testObject[currentTestRun].testFile[0].rotation);
  controlP5.controller("ROTATE_MIDDLE").setValue(testObject[currentTestRun].testFile[1].rotation);
  controlP5.controller("ROTATE_RIGHT").setValue(testObject[currentTestRun].testFile[2].rotation);
}

