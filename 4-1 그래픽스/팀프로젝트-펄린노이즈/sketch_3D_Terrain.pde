int cols, rows;
int scl = 20;
int w=2000;
int h=2000;
int y = 100;
int sw = 1;
float[][] terrain;
float xf = 0.005;
float yf = 0.015;
float sky_zoff = 0.0;  
float zincrement = 0.02; 

void setup() {
  size(800, 600, P3D);
  cols=w/scl;
  rows=h/scl;
  terrain = new float[cols][rows];
}

float flying;
float move;
  
void draw(){
  sky();
  land();
}

void land() {
  flying -= 0.1;
  float yoff=flying;
  for (int y=0; y<rows; y++) {
    float xoff=0;
    for (int x=0; x<cols; x++) {
      terrain[x][y]=map(noise(xoff, yoff), 0, 1, -50, 80);
      xoff +=0.2;
    }
    yoff +=0.2;
  }
  
  noStroke();
  fill(60,200,75);
  pointLight(0, y, 0, 255, 255, 255);
  y+=1*sw;
  if(y>=255) sw=sw*-1;
  else if(y<=100) sw=sw*-1;
  
  translate(width/2, height/2);
  rotateX(PI/3);
  translate(-w/2, -h/3);

  for (int y=0; y<rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x=0; x<cols; x++) {
      vertex(x*scl, y*scl, terrain[x][y]); 
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}

void sky() {
  loadPixels();
  move -= 0.01;
  float sky_xoff = move;
  for (int x = 0; x < width; x++) {
    sky_xoff += xf; 
    float sky_yoff = 0.0;
    for (int y = 0; y < height; y++) {
      sky_yoff += yf;
      float red = map(noise(sky_xoff, sky_yoff, sky_zoff), 0, 1, 10, 255);
      float green = map(noise(sky_xoff, sky_yoff, sky_zoff), 0, 1, 120, 255);
      float blue = map(noise(sky_xoff, sky_yoff, sky_zoff), 0, 1, 240, 255);
      pixels[x + y * width] = color(red, green, blue);
    }
  }
  updatePixels();
  sky_zoff += zincrement;
}
