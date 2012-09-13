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

// The Application Settings managed by appSettingsXml class.
AppSettingsXml appSettingsXml;

// GUI to controll the application
GUI gui;

// TestXml
TestXml testXml;
TestObject[] testObject;
int currentTestRun = 0;

// Other stuff
PFont font;
PImage domegrid;



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
  
  
  // Create a GUI class instance
  gui = new GUI();
  gui.setup(this);
  
  
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
 * Processing keyPressed
 */
 void keyPressed() {
   switch(key) {
     case '1':
       println("key 1 pressed");
       break;
     
     case '2':
       println("key 2 pressed");
       break;
     
     default:
       println("default key pressed");
       break;
   }
 }
 



/**
 * controlP5 Events
 */
void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.controller().id());
  
  switch(theEvent.controller().id()){
    // Object RGB
    case(30):
      testObject[currentTestRun].testGraphic[0].transparency = (int)(theEvent.controller().value());
      testObject[currentTestRun].testGraphic[1].transparency = (int)(theEvent.controller().value());
      testObject[currentTestRun].testGraphic[2].transparency = (int)(theEvent.controller().value());
      break;
    case(31):
      testObject[currentTestRun].testGraphic[0].scale = (int)(theEvent.controller().value());
      testObject[currentTestRun].testGraphic[1].scale = (int)(theEvent.controller().value());
      testObject[currentTestRun].testGraphic[2].scale = (int)(theEvent.controller().value());
      break;
    case(320):
      testObject[currentTestRun].testGraphic[0].rotation = (int)(theEvent.controller().value());
      break;
    case(321):
      testObject[currentTestRun].testGraphic[1].rotation = (int)(theEvent.controller().value());
      break;
    case(322):
      testObject[currentTestRun].testGraphic[2].rotation = (int)(theEvent.controller().value());
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
  gui.setControllerValue();
}

