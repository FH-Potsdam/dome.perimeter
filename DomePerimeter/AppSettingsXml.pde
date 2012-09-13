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
  PApplet p5;
  boolean displayInDome;
  boolean domegridDisplay;
  int[] backgroundColor = new int[3];
  int latitudeDegree;
  String testFile;


  /**
   * Constuctor
   */
  AppSettingsXml(PApplet p) {
    p5 = p;
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
      XMLElement appXml = new XMLElement(p5, file);
      DEBUGINFO("XML\n" + appXml);
      
      /* Read the xml content */
      read(appXml);
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
  void setup() {
    DEBUGINFO("setup()");
    // Set Processing settings
    if(displayInDome == true) {
      size(1920, 1920, OPENGL);
    } else {
      size(800, 800, OPENGL);
    }
    frameRate(30);
    smooth();
  }
  
  
  /**
   * read
   */
  void read(XMLElement xml){
    DEBUGINFO("read()");
    
    /* Get all the child elements from xml file. */
    XMLElement[] settingsXml = xml.getChildren();
      
    /* Set the application variables from xml content. */
    /* If displayInDome tag exists */
   if(settingsXml[0].getName().equals("displayInDome")) {
      DEBUGINFO("displayInDome tag ok");
      if(settingsXml[0].getContent().equals("true")) {
        displayInDome = true;
     } else {
        displayInDome = false;
      }
    } else {
      DEBUGINFO("displayInDome tag not found");
      setDefault_displayInDome();
    }

    /* Set the output resolution */
    if(settingsXml[1].getName().equals("displayDomegrid")) {
      if(settingsXml[1].getContent().equals("true")) {
        domegridDisplay = true;
      } else {
        domegridDisplay = false;
      }
    } else {
      setDefault_domegridDisplay();
    }
      
    /* Set the background colors */
    if(settingsXml[2].getName().equals("backgroundColor")) {
      backgroundColor[0] = settingsXml[2].getIntAttribute("r");
      backgroundColor[1] = settingsXml[2].getIntAttribute("g");
      backgroundColor[2] = settingsXml[2].getIntAttribute("b");
    } else {
      setDefault_backgroundColor();
    }
      
    /* Set the latitude degrees */
    if(settingsXml[3].getName().equals("latitude_degree")) {
      latitudeDegree = int(settingsXml[3].getContent() );
      DEBUGINFO("latitudeDegree: " + latitudeDegree);
    } else {
      setDefault_latitudeDegree();
    }
      
    /* Set the xml testfile path */
    if(settingsXml[4].getName().equals("testFile")) {
      testFile = settingsXml[4].getContent();
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
  void setDefault_backgroundColor(){
    backgroundColor[0] = 255;
    backgroundColor[1] = 255;
    backgroundColor[2] = 255;
  }
  void setDefault_latitudeDegree(){
    latitudeDegree = 10;
  }
  void setDefault_testFile(){
    testFile = selectInput();
  }
  
  
  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[AppSettings] " + s);
  }
  
}

