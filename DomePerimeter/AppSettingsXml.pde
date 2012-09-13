/**
 * AppSettings
 *
 * Die classe wird benutzt um die app settings zu verwalten.
 * es wird eine xml datei eingelesen und die tags/attributes geparsed.
 */
class AppSettingsXml {

  /**
   * Variables
   */
  boolean displayInDome;
  boolean domegridDisplay;
  int[] backgroundColor = new int[3];
  //int bgR = 255, bgG = 255, bgB = 255;
  int latitudeDegree = 10;
  String tempTestFilename;


  /**
   * Constuctor
   */
  AppSettingsXml() {
    backgroundColor[0] = 255;
    backgroundColor[1] = 255;
    backgroundColor[2] = 255;
  }


  /**
   * read
   */
  void read(PApplet p, String file) {
    // Application Settings XML (Load an XML file)
    XMLElement appXml = new XMLElement(p, file);
    //println("[AppSettings] read\n" + appXml);

    // Get all the child elements from xml file.
    XMLElement[] settingsXml = appXml.getChildren();
    //println("[AppSettings] displayInDome = " + settingsXml[0].getContent());

    // set the application variables from xml content.
    if(settingsXml[0].getContent().equals("true")) {
      displayInDome = true;
    } 
    else {
      displayInDome = false;
    }

    // Set the output resolution
    if(settingsXml[1].getContent().equals("true")) {
      domegridDisplay = true;
    } 
    else {
      domegridDisplay = false;
    }

    // Set the background colors
    backgroundColor[0] = settingsXml[2].getIntAttribute("r");
    backgroundColor[1] = settingsXml[2].getIntAttribute("g");
    backgroundColor[2] = settingsXml[2].getIntAttribute("b");

    // Set the latitude degrees
    latitudeDegree = int(settingsXml[3].getContent() );
    //println("[AppSettings] latitudeDegree: " + latitudeDegree);

    // Set the xml testfile path
    tempTestFilename = settingsXml[4].getContent();
    //println("[AppSettings] " + tempTestFilename);
  }


  /**
   * setup
   */
  void setup() {
    // Set Processing settings
    if(appSettingsXml.displayInDome == true) {
      size(1920, 1920, OPENGL);
    } 
    else {
      size(800, 800, OPENGL);
    }
    frameRate(30);
    smooth();
  }
}

