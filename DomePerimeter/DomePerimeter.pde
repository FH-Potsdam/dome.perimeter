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

PImage domegrid;
PFont font;

boolean displayInDome;
boolean domegridDisplay;
int bgR = 255, bgG = 255, bgB = 255;
int latitudeDegree = 10;

TestObject[] testObject;
int currentTestRun = 0;



/**
 * Processing main setup
 */
void setup(){
  // Application Settings XML (Load an XML file)
  XMLElement appXml = new XMLElement(this, "appSettings.xml");
  // println("Xml: " + appXml);
  
  // Get all the child elements from xml file.
  XMLElement[] settingsXml = appXml.getChildren();
  //println("displayInDome: " + settingsXml[0].getContent());
  
  // set the application variables from xml content.
  if(settingsXml[0].getContent().equals("true")) {
    displayInDome = true;
  } else {
    displayInDome = false;  
  }
  
  // Set the output resolution
  if(settingsXml[1].getContent().equals("true")){
    domegridDisplay = true;
  } else {
    domegridDisplay = false;
  }
  
  // Set the background colors
  bgR = settingsXml[2].getIntAttribute("r");
  bgG = settingsXml[2].getIntAttribute("g");
  bgB = settingsXml[2].getIntAttribute("b");
  
  // Set the latitude degrees
  latitudeDegree = int(settingsXml[3].getContent() );
  //println("latitudeDegree: " + latitudeDegree);
  
  // Set the xml testfile path
  String tempTestFilename = settingsXml[4].getContent();
  //println(tempTestFilename);
  
  
  
  
  if(displayInDome == true){
    size(1920, 1920, OPENGL);
  } else {
    size(800, 800, OPENGL);
  }
  frameRate(30);
  smooth();
  
  
  
  // load a font for information
  font = loadFont("font/Unibody8-Regular.vlw");
  
  
  
  // Load an XML document
  XMLElement xml = new XMLElement(this, tempTestFilename);
  println("xml :\n" + xml);
  // Get all the child elements
  XMLElement[] children = xml.getChildren();
  //println("children.length: "+children.length);
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
  controlP5.addSlider("BG R", 0,255,bgR, 10,30, 100,14).setId(10);
  controlP5.addSlider("BG G", 0,255,bgG, 10,50, 100,14).setId(11);
  controlP5.addSlider("BG B", 0,255,bgB, 10,70, 100,14).setId(12);
  // Dome Grid
  controlP5.addToggle("DOMEGRID", domegridDisplay, 10,90, 14,14).setId(20);
  // TEST PARAMETER
  controlP5.addSlider("TRANSPARENCY", 0,255,testObject[0].testFile[0].transparency, 10,height-120, 100,14).setId(30);
  controlP5.addSlider("SCALE", 0,255,testObject[0].testFile[0].scale, 10,height-100, 100,14).setId(31);
  controlP5.addSlider("ROTATE_LEFT", -180,180,testObject[0].testFile[0].rotation, 10,height-80, 100,14).setId(320);
  controlP5.addSlider("ROTATE_MIDDLE", -180,180,testObject[0].testFile[1].rotation, 10,height-60, 100,14).setId(321);
  controlP5.addSlider("ROTATE_RIGHT", -180,180,testObject[0].testFile[2].rotation, 10,height-40, 100,14).setId(322);
  controlP5.addSlider("LATITUDE_DEGREE", 0,90,latitudeDegree, 10,height-20, 100,14).setId(33);
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
  if(domegridDisplay == true) {
    tint(bgR, bgG, bgB);
    image(domegrid, 0, 0, width, height);
    noTint();
  } else {
    fill(bgR, bgG, bgB);
    ellipse(width/2, height/2, width, height);
  }
  
  // Typo für gui beschreibung, test ergebniss etc.
  fill(255);
  textFont(font);
  text("BACKGROUND COLOR:", 10, 20);
  text("TEST PARAMETER:", 10, height-130);
  text("FrameRate: "+(int)frameRate+"\nFrameCount: "+frameCount, width-120, 20);
  text("TEST-RUN NO: "+currentTestRun, width-120, height-40);
  
  testObject[currentTestRun].display(latitudeDegree);
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
      latitudeDegree = (int)(theEvent.controller().value());
      break;
    
    // BG Transparency, Scale, Rotation
    case(10):
      bgR = (int)(theEvent.controller().value());
      break;
    case(11):
      bgG = (int)(theEvent.controller().value());
      break;
    case(12):
      bgB = (int)(theEvent.controller().value());
      break;
    
    // Domwrid display  
    case(20):
      int tempVar;
      tempVar = (int)(theEvent.controller().value());
      //println(tempVar);
      if(tempVar == 0) domegridDisplay = false;
      else domegridDisplay = true;
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

