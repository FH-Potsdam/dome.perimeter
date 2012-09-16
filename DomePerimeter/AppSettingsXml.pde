/**
 * AppSettingsXml
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
  String domegridPath;
  int[] backgroundColor = new int[3];
  int latitudeDegree;
  String testFile;


  /**
   * Constuctor
   */
  AppSettingsXml() {
    backgroundColor[0] = 255;
    backgroundColor[1] = 255;
    backgroundColor[2] = 255;
    latitudeDegree = 10;
  }


  /**
   * load
   *
   * @param file The Xml file
   */
  void load(String file) {
    DEBUGINFO("load()");
    
    /* check if the file exist */
    File f = new File(dataPath(file));
    if (f.exists()) {
      DEBUGINFO("File exist");
      
      /* Application Settings XML (Load an XML file) */
      XML xml = loadXML(file);
      DEBUGINFO("XML\n" + xml);
      
      /* Read the xml content */
      read(xml);
    }
    /* if no file exist... */
    else {
      DEBUGINFO("File does not exist");
      setDefault();
    } /* End if file exists */
  }
  
  
  /** 
   * setup
   */
  void setup(){
    DEBUGINFO("setup()");
    if(displayInDome == true) {
      size(1920, 1920);
    } else {
      size(800, 800);
    }
    frameRate(30);
    smooth();
  }
  
  
  /**
   * read
   */
  void read(XML xml){
    DEBUGINFO("read()");
    
    /* Set the application variables from xml content. */
    
    XML[] displayInDomeTag = xml.getChildren("displayInDome");
    /* If displayInDome tag exists */
    if(displayInDomeTag.length == 1) {
      if(displayInDomeTag[0].getContent().equals("true")) {
        displayInDome = true;
     } else {
        displayInDome = false;
      }
    } else {
      setDefault_displayInDome();
    }

    /* Set the output resolution */
    XML[] domegridTag = xml.getChildren("domegrid");
    if(domegridTag.length == 1) {
      /* Get the filepath */
      domegridPath = domegridTag[0].getContent();
      /* check if display is true. */
      if(domegridTag[0].getString("display").equals("true")) {
        domegridDisplay = true;
      } else {
        domegridDisplay = false;
      }
    } else {
      setDefault_domegridDisplay();
    }
      
    /* Set the background colors */
    XML[] backgroundColorTag = xml.getChildren("backgroundColor");
    if(backgroundColorTag.length == 1) {
      /* save the r, g, b attribute value to temporary variable */
      int tempR = backgroundColorTag[0].getInt("r");
      int tempG = backgroundColorTag[0].getInt("g");
      int tempB = backgroundColorTag[0].getInt("b");
      
      /* check if the integer is smaller than 255 */
      if(tempR <= 255) backgroundColor[0] = tempR;
      else if(tempR > 0) backgroundColor[0] = 0;
      else backgroundColor[0] = 255;
      
      if(tempG <= 255) backgroundColor[1] = tempG;
      else if(tempG > 0) backgroundColor[1] = 0;
      else backgroundColor[1] = 255;
      
      if(tempB <= 255) backgroundColor[2] = tempB;
      else if(tempB > 0) backgroundColor[2] = 0;
      else backgroundColor[2] = 255;
    }
    else {
      setDefault_backgroundColor();
    }
      
    /* Set the latitude degrees */
    XML[] latitude_degreeTag = xml.getChildren("latitude_degree");
    if(latitude_degreeTag.length == 1) {
      int tempLat = int(latitude_degreeTag[0].getContent() );
      // TODO: /* check if xml content has the correct value */
      latitudeDegree = tempLat;
      DEBUGINFO("latitudeDegree: " + latitudeDegree);
    } else {
      setDefault_latitudeDegree();
    }
      
    /* Set the xml testfile path */
    XML[] testFileTag = xml.getChildren("testFile");
    if(testFileTag.length == 1) {
      testFile = testFileTag[0].getContent();
      DEBUGINFO(testFile);
    } else {
      setDefault_testFile();
    }
  }
  
  
  /**
   * default values
   */
  void setDefault(){
    setDefault_displayInDome();
    setDefault_domegridDisplay();
    setDefault_domegridPath();
    setDefault_backgroundColor();
    setDefault_latitudeDegree();
    setDefault_testFile();
  }
  void setDefault_displayInDome(){
    displayInDome = false;
  }
  void setDefault_domegridDisplay(){
    domegridDisplay = true;
  }
  void setDefault_domegridPath(){
    domegridPath = "domegrid/domegrid_lat.png";
  }
  void setDefault_backgroundColor(){
    backgroundColor[0] = 255;
    backgroundColor[1] = 255;
    backgroundColor[2] = 255;
  }
  void setDefault_latitudeDegree(){
    latitudeDegree = 10;
  }
  void setDefault_testFile(){
    selectInput("Select a testfile to process:", "fileSelected");
  }
  

  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[AppSettings] " + s);
  }
  
}

