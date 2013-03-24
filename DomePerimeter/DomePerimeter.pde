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
 * Dome.Perimeter is developed by Prof. Dufke
 * Code by Paul Vollmer <paul.vollmer@fh-potsdam.de>
 * 
 * FH-Potsdam
 * University of Applied Science
 *
 * @author               Paul Vollmer
 * @modified             2012.09.15
 * @version              0.1.41a
 *
 * processing    version 2.0b8
 * controlP5     version 2.0.4
 */

import controlP5.*;


// The Application Settings managed by appSettingsXml class.
AppSettingsXml appSettingsXml = new AppSettingsXml();

// GUI to controll the application
GUI gui;

// TestXml
TestXml testXml = new TestXml();

int currentTestRun = 0;

// Other stuff
PFont font;
PImage domegrid;



/**
 * Processing main setup
 */
void setup() {
  // Load the application settings
  appSettingsXml.load("appSettings.xml");
  appSettingsXml.setup();
  
  /* Create a TestXml class Instance */
  testXml.load(appSettingsXml.testFile);

  /* Create a GUI class instance */
  gui = new GUI();
  gui.setup(this);
    
  /* load a font for informations and other text stuff */
  font = loadFont("font/Unibody8-Regular.vlw");
  /* load the domegrid image */
  domegrid = loadImage(appSettingsXml.domegridPath);
}




/**
 * Processing main draw
 */
void draw() {
  background(20);
  if(appSettingsXml.domegridDisplay == true) {
    tint(appSettingsXml.backgroundColor[0], appSettingsXml.backgroundColor[1], appSettingsXml.backgroundColor[2]);
    image(domegrid, 0, 0, width, height);
    noTint();
  } 
  else {
    fill(appSettingsXml.backgroundColor[0], appSettingsXml.backgroundColor[1], appSettingsXml.backgroundColor[2]);
    ellipse(width/2, height/2, width, height);
  }

  /* Typo für gui beschreibung, test ergebniss etc. */
  fill(255);
  textFont(font);
  text("BACKGROUND COLOR:", 10, 20);
  text("TEST PARAMETER:", 10, height-130);
  text("FRAMERATE: "+(int)frameRate+"\nFRAMECOUNT: "+frameCount, width-120, 20);
  text("TEST-RUN NO: "+currentTestRun, width-120, height-40);

  testXml.testObject[currentTestRun].display(appSettingsXml.latitudeDegree);
  //println(testXml.testObject.length);
}


/**
 * Processing keyPressed
 */
void keyPressed() {
  //println("key " + key + " pressed");
  
  switch(key) {
  /* Domegrid on/off */
  case 'q':
    if(appSettingsXml.domegridDisplay == true) {
      appSettingsXml.domegridDisplay = false;
      gui.setDomegridValue(0);
    } else if(appSettingsXml.domegridDisplay == false) {
      appSettingsXml.domegridDisplay = true;
      gui.setDomegridValue(1);
    }
    break;
  
  /* Rotate Left + */
  case 'x':
    if(testXml.testObject[currentTestRun].testGraphic[0].rotation <= 180) {
      testXml.testObject[currentTestRun].testGraphic[0].rotation++;
      gui.setControllerValueRotateLeft(currentTestRun, testXml.testObject[currentTestRun].testGraphic[0].rotation);
      //println("RotateLeft " + testXml.testObject[currentTestRun].testGraphic[0].rotation);
    }
    break;
  /* Rotate Left - */
  case 'y':
    if(testXml.testObject[currentTestRun].testGraphic[0].rotation >= -180){
      testXml.testObject[currentTestRun].testGraphic[0].rotation--;
      gui.setControllerValueRotateLeft(currentTestRun, testXml.testObject[currentTestRun].testGraphic[0].rotation);
      //println("RotateLeft " + testXml.testObject[currentTestRun].testGraphic[0].rotation);
    }
    break;
  
  /* Rotate Middle + */
  case 'c':
    if(testXml.testObject[currentTestRun].testGraphic[1].rotation <= 180) {
      testXml.testObject[currentTestRun].testGraphic[1].rotation++;
      gui.setControllerValueRotateMiddle(currentTestRun, testXml.testObject[currentTestRun].testGraphic[1].rotation);
      println("RotateLeft " + testXml.testObject[currentTestRun].testGraphic[1].rotation);
    }
    break;
  /* Rotate Middle - */
  case 'v':
    if(testXml.testObject[currentTestRun].testGraphic[1].rotation >= -180){
      testXml.testObject[currentTestRun].testGraphic[1].rotation--;
      gui.setControllerValueRotateMiddle(currentTestRun, testXml.testObject[currentTestRun].testGraphic[1].rotation);
      println("RotateLeft " + testXml.testObject[currentTestRun].testGraphic[1].rotation);
    }
    break;
    
  /* Rotate Right + */
  case 'm':
    if(testXml.testObject[currentTestRun].testGraphic[2].rotation <= 180) {
      testXml.testObject[currentTestRun].testGraphic[2].rotation++;
      gui.setControllerValueRotateRight(currentTestRun, testXml.testObject[currentTestRun].testGraphic[2].rotation);
      println("RotateLeft " + testXml.testObject[currentTestRun].testGraphic[2].rotation);
    }
    break;
  /* Rotate Right - */
  case 'n':
    if(testXml.testObject[currentTestRun].testGraphic[2].rotation >= -180){
      testXml.testObject[currentTestRun].testGraphic[2].rotation--;
      gui.setControllerValueRotateRight(currentTestRun, testXml.testObject[currentTestRun].testGraphic[2].rotation);
      println("RotateLeft " + testXml.testObject[currentTestRun].testGraphic[2].rotation);
    }
    break;
  
  /* Next Run */
  case '9':
    if(currentTestRun >= testXml.testObject.length-1) {
    } else {
      currentTestRun++;
    }
    break;
  /* Previous Run */
  case '0':
    if(currentTestRun <= 0){
    } else {
      currentTestRun--;
    }
    break;
  } /* End swithc */
}


/**
 * fileSelected
 */
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());
  }
}


/**
 * controlP5 Events
 */
void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.controller().id());

  switch(theEvent.controller().id()) {
    /* Object RGB */
    case(30):
    testXml.testObject[currentTestRun].testGraphic[0].transparency = (int)(theEvent.controller().value());
    testXml.testObject[currentTestRun].testGraphic[1].transparency = (int)(theEvent.controller().value());
    testXml.testObject[currentTestRun].testGraphic[2].transparency = (int)(theEvent.controller().value());
    break;
    case(31):
    testXml.testObject[currentTestRun].testGraphic[0].scale = (int)(theEvent.controller().value());
    testXml.testObject[currentTestRun].testGraphic[1].scale = (int)(theEvent.controller().value());
    testXml.testObject[currentTestRun].testGraphic[2].scale = (int)(theEvent.controller().value());
    break;
    case(320):
    testXml.testObject[currentTestRun].testGraphic[0].rotation = (int)(theEvent.controller().value());
    break;
    case(321):
    testXml.testObject[currentTestRun].testGraphic[1].rotation = (int)(theEvent.controller().value());
    break;
    case(322):
    testXml.testObject[currentTestRun].testGraphic[2].rotation = (int)(theEvent.controller().value());
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
    } 
    else {
      currentTestRun--;
      setControllerValue();
      println(currentTestRun);
    }
    break;

    // NEXT
    case(41):
    if(currentTestRun >= testXml.testObject.length-1) {
      println(currentTestRun);
    } 
    else {
      currentTestRun++;
      setControllerValue();
      println(currentTestRun);
    }
    break;
  }
}



void setControllerValue() {
  gui.setControllerValue(currentTestRun);
}


