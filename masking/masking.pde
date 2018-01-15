/*
Yawuar Serna Delgado

Web - Research MT

Trying to play an animation inside a bodymask.
Secondly, trying to play a ball inside a bodymask

*/

// Import the Kinect library
import KinectPV2.*;

// Initialise the kinect class
KinectPV2 kinect;

int distance = 300;
int distance2 = 1500;

PImage mask;
PImage pixar;

ArrayList<PVector> spots;

void setup() {
  size(512, 424, P3D);;
  kinect = new KinectPV2(this);
  kinect.enableDepthImg(true);
  kinect.enableBodyTrackImg(true);
  kinect.init();
  
  pixar = loadImage("pixar.jpg");
  mask = createImage(512, 424, RGB);
}

void draw() {
  background(0);
  //image(kinect.getDepthImage(), 0, 0);
  int[] depthValues = kinect.getRawDepthData();
  mask.width = 512;
  mask.height = 424;
  mask.loadPixels();
  
  int [] bodyData = kinect.getRawBodyTrack();
  
  for(int y = 0; y < 424; y++) {
    for(int x = 0; x < 512; x++) {
      int i = x + (y * 512);
      int currentDepthValue = depthValues[i];
      // check if there is a person
      if(bodyData[i] != 255) {
        if(currentDepthValue > distance && currentDepthValue < distance2/* && x > 175 && x < 350*/) {
          mask.pixels[i] = color(255, 255, 255);
        }
      } else {
        mask.pixels[i] = color(0, 0, 0);
      }
    }
  }
  
  
  mask.updatePixels();
  pixar.mask(mask);
  image(pixar, 0, 0);
}