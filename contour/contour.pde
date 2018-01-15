import gab.opencv.*;
import KinectPV2.*;
import org.opencv.imgproc.Imgproc;
import org.opencv.core.Point;
import org.opencv.core.MatOfPoint2f;

KinectPV2 kinect;
OpenCV opencv;

float polygonFactor = 1;

int threshold = 5;

//Distance in cm
int maxD = 1000; //4.5m
int minD = 100; //50cm

int depthWidth = 512;
int depthHeight = 424;

void setup() {
  size(512, 424, P3D);
  opencv = new OpenCV(this, 512, 424);
  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);
  kinect.enablePointCloud(true);

  kinect.init();
}

void draw() {
  background(0);
  noFill();
  //noStroke();
  strokeWeight(3);
  opencv.loadImage(kinect.getBodyTrackImage());
  opencv.gray();
  opencv.threshold(threshold);
  ArrayList<Contour> contours = opencv.findContours(false, false);
  if (contours.size() > 0) {
    for (Contour contour : contours) {
      contour.setPolygonApproximationFactor(polygonFactor);
      if (contour.numPoints() > 50) {
        beginShape();
        stroke(0, 200, 200);
        for (PVector point : contour.getPolygonApproximation ().getPoints()) {
          vertex(point.x, point.y, 100, 100);
        }
        endShape();
      }
    }
  }
}