/**
 * AppSettings
 *
 * Die classe wird benutzt um die app settings zu verwalten.
 * es wird eine xml datei eingelesen und die tags/attributes geparsed.
 */
class AppSettingsXml {

  /*
   * Variables
   */
  //String filePath;
  boolean displayInDome;
  boolean domegridDisplay;
  int bgR = 255, bgG = 255, bgB = 255;
  int latitudeDegree = 10;
  String tempTestFilename;
  
  
  /*
   * Constuctor
   */
  AppSettingsXml(){}
  
  
  /*
   * read
   */
  void read(PApplet p, String file){
    // Application Settings XML (Load an XML file)
    XMLElement appXml = new XMLElement(p, file);
    println("[AppSettings] read\n" + appXml);
    
    // Get all the child elements from xml file.
    XMLElement[] settingsXml = appXml.getChildren();
    println("[AppSettings] displayInDome = " + settingsXml[0].getContent());
  
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
    println("[AppSettings] latitudeDegree: " + latitudeDegree);
  
    // Set the xml testfile path
    tempTestFilename = settingsXml[4].getContent();
    println("[AppSettings] " + tempTestFilename);
  
  }
  
  
}

