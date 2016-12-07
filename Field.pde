//GLOBAL VARIABLES
PImage stigIm = createImage(int(2400), int(2400), ARGB);
field2d field = new field2d(stigIm);
//STIGMERGY VARIABLES
float scatter = 10; // influence radius 
int nSamples = 70; //200 - how many samples it takes (precise)
float stigS = 0.8; //0.3 - stigmergy strength
float fStrength = 0.5;

float decay = 1.5; // - decay of pheromenes
PImage img; //HACK uff

//CLASS
class field2d {
  //FIELD

  int nx, ny;
  float[] values;

  int X_offset = 1200;
  int Y_offset = 1200;

  //CONSTRUCTOR
  field2d(PImage _img) {
    img = _img;
    nx = img.width;
    ny = img.height;
    values = new float[nx*ny];
  }

  //METHODS
  int id(int x, int y) {
    return (x+X_offset)+(y+Y_offset)*nx;
  }

  void addValue(Vec3D v, float inc) {
    int id = id(floor(v.x), floor(v.y));
    if (id < values.length) { //TODO catch out of the field
     values[id] += inc;
     //values[id] = constrain(values[id], 0, 5);

      //img.pixels[id] = color(255-values[id]*50, values[id]*255, 255);
      img.pixels[id] = color(255, 255, 255, values[id]);
    }
  }

  float readValue(Vec3D v) {
    float val = 0;
    int id = id(floor(v.x), floor(v.y));
    if (id < values.length)
      val = values[id];
    return val;
  }

  void decay(float mult) {
    for (int i=0; i< nx*ny; i++) {
      if (values[i]>0) {
        values[i]*=mult;
        img.pixels[i] = color(255, 255, 255, values[i]);
      }
    }
  }

  void reset() {
    for (int i=0; i< nx*ny; i++) {
      values[i]=0;
    }
  }

  void drawField() {
   // img.loadPixels();
   // for (int i = 0; i < img.pixels.length; i++) img.pixels[i] = color(255-values[i]*50, values[i]*255, 255);
   // for (int i = 0; i < img.pixels.length; i++) img.pixels[i] = color(255, 255, 255, values[i]);
  //  img.updatePixels();
    image(img, -X_offset, -Y_offset);
  }
}