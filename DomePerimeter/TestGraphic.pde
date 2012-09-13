/**
 * TestGraphic
 */
class TestGraphic {

  // if our file is a SVG file, we set the testType integer to 1
  // if our file is a Image file, we set the testType integer to 2
  int testType;


  PImage image;
  PShape shape;

  // Variables o manipulate the test file object.
  int transparency;
  int scale;
  int rotation;


  /**
   * Constructor
   *
   * @param src
   *        Filepath
   * @param transparency
   *        transparency of the file
   * @param scale
   *        scale of the file
   * @param rotation
   *        rotation of the file
   */
  TestGraphic(String src, int transparency, int scale, int rotation) {
    DEBUGINFO("Constuctor");
    
    String[] temp = split(src, ".");
    //DEBUGINFO(temp[temp.length-1]);

    // Check if the file is a SVG type.
    if(temp[temp.length-1].equals("svg")) {
      DEBUGINFO("VECTOR");
      shape = loadShape(src);
      testType = 1;
    }
    else if(temp[temp.length-1].equals("png") ||
            temp[temp.length-1].equals("jpg") ||
            temp[temp.length-1].equals("tif")) {
      DEBUGINFO("PIXEL");
      image = loadImage(src);
      testType = 2;
    }

    this.transparency = transparency;
    this.scale = scale;
    this.rotation = rotation;

    DEBUGINFO("src = " + src +
              "\t, transparency = " + transparency +
              "\t, scale = " + scale +
              "\t, rotation = " + rotation +
              "\t, testType = " + testType + " [" + temp[temp.length-1] + "]");
  }



  /**
   * display
   *
   * @param rad
   *        radius
   * @param r
   *        rotaion
   */
  void display(int rad, float r) {
    // Calculate position
    float x = rad * sin(radians(rotation));
    float y = rad * cos(radians(rotation));
    DEBUGINFO("rotation: " + rotation + ",\t x: " + x + ",\t y: " + y);

    pushMatrix();
    translate(x+width/2, y+height/2);
    rotate(radians(-rotation));
    translate(-(scale/2), -(scale/2));

    // switch between our file type
    // we will choose between vector and pixel file.
    switch(testType) {
    case 1:
      shape(shape, 0, 0, scale, scale);
      fill(appSettingsXml.backgroundColor[0], appSettingsXml.backgroundColor[1], appSettingsXml.backgroundColor[2], transparency);
      ellipse(scale/2, scale/2, scale+5, scale+5);
      break;

    case 2:
      tint(255, transparency);
      image(image, 0, 0, scale, scale);
      noTint();
      break;

    default:
      DEBUGINFO("Something went wrong :(");
    }

    popMatrix();
  }
  
  
  /**
   * This will be used for debugging stuff.
   */
  void DEBUGINFO(String s){
    //println("[TestGraphic] " + s);
  }
}

