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

final static String GUI_BACKGROUND_R    = "BG R";
final static String GUI_BACKGROUND_G    = "BG G";
final static String GUI_BACKGROUND_B    = "BG B";
final static String GUI_DOMEGRID        = "DOMEGRID";
final static String GUI_TRANSPARENCY    = "TRANSPARENCY";
final static String GUI_SCALE           = "SCALE";
final static String GUI_ROTATE_LEFT     = "ROTATE_LEFT";
final static String GUI_ROTATE_MIDDLE   = "ROTATE_MIDDLE";
final static String GUI_ROTATE_RIGHT    = "ROTATE_RIGHT";
final static String GUI_LATITUDE_DEGREE = "LATITUDE_DEGREE";
final static String GUI_PREV            = "PREV";
final static String GUI_NEXT            = "NEXT";

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
    controlP5.addSlider(GUI_BACKGROUND_R, 0,255,appSettingsXml.backgroundColor[0], 10,30, 100,14).setId(10);
    controlP5.addSlider(GUI_BACKGROUND_G, 0,255,appSettingsXml.backgroundColor[1], 10,50, 100,14).setId(11);
    controlP5.addSlider(GUI_BACKGROUND_B, 0,255,appSettingsXml.backgroundColor[2], 10,70, 100,14).setId(12);
    
    // Dome Grid
    controlP5.addToggle(GUI_DOMEGRID, appSettingsXml.domegridDisplay, 10,90, 14,14).setId(20);
    
    // TEST PARAMETER
    controlP5.addSlider(GUI_TRANSPARENCY, 0,255,testXml.testObject[0].testGraphic[0].transparency, 10,height-120, 100,14).setId(30);
    controlP5.addSlider(GUI_SCALE, 0,255,testXml.testObject[0].testGraphic[0].scale, 10,height-100, 100,14).setId(31);
    controlP5.addSlider(GUI_ROTATE_LEFT, -180,180,testXml.testObject[0].testGraphic[0].rotation, 10,height-80, 100,14).setId(320);
    controlP5.addSlider(GUI_ROTATE_MIDDLE, -180,180,testXml.testObject[0].testGraphic[1].rotation, 10,height-60, 100,14).setId(321);
    controlP5.addSlider(GUI_ROTATE_RIGHT, -180,180,testXml.testObject[0].testGraphic[2].rotation, 10,height-40, 100,14).setId(322);
    controlP5.addSlider(GUI_LATITUDE_DEGREE, 0,90,appSettingsXml.latitudeDegree, 10,height-20, 100,14).setId(33);
    
    // Test
    controlP5.addButton(GUI_PREV, 0, width-120,height-30, 50,14).setId(40);
    controlP5.addButton(GUI_NEXT, 0, width-60,height-30, 50,14).setId(41);
  }


  /**
   * setControllerValue
   */
  void setControllerValue(int i){
    DEBUGINFO("setControllerValue()");
    setControllerValueTransparency(i, testXml.testObject[i].testGraphic[0].transparency);
    setControllerValueScale(i, testXml.testObject[i].testGraphic[0].scale);
    setControllerValueRotateLeft(i, testXml.testObject[i].testGraphic[0].rotation);
    setControllerValueRotateMiddle(i, testXml.testObject[i].testGraphic[1].rotation);
    setControllerValueRotateRight(i, testXml.testObject[i].testGraphic[2].rotation);
  }
  void setControllerValueTransparency(int i, float v){
    controlP5.controller(GUI_TRANSPARENCY).setValue(v);
  }
  void setControllerValueScale(int i, float v){
    controlP5.controller(GUI_SCALE).setValue(v);
  }
  void setControllerValueRotateLeft(int i, float v){
    controlP5.controller(GUI_ROTATE_LEFT).setValue(v);
  }
  void setControllerValueRotateMiddle(int i, float v){
    controlP5.controller(GUI_ROTATE_MIDDLE).setValue(v);
  }
  void setControllerValueRotateRight(int i, float v){
    controlP5.controller(GUI_ROTATE_RIGHT).setValue(v);
  }
  
  
  void setDomegridValue(float f){
    controlP5.controller(GUI_DOMEGRID).setValue(f);
  }
  
  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[GUI] " + s);
  }
}

