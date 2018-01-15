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
int maxD = 1000; //10m
int minD = 100; //200cm

int depthWidth = 512;
int depthHeight = 424;

float circleX;
float xspeed = 2;

Drop [] drops = new Drop[100];

void setup() {
  size(512, 424, P3D);

  circleX = 0;

  opencv = new OpenCV(this, 512, 424);
  kinect = new KinectPV2(this);

  kinect.enableBodyTrackImg(true);
  kinect.enablePointCloud(true);

  kinect.init();

  for (int i = 0; i < drops.length; i++) {
    drops[i] = new Drop();
  }
}

void draw() {
  background(0);
  noFill();
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

  showAnimation(contours);
}

void showAnimation(ArrayList<Contour> contours) {
  noStroke();
  if (contours.size() > 0) {
    for (Contour contour : contours) {
      contour.setPolygonApproximationFactor(polygonFactor);
      if (contour.numPoints() > 50) {
        for (int i = 0; i < drops.length; i++) {
          boolean outside = inContour(drops[i].getX() , drops[i].getY() + 20, contour);
          if(!outside) {
            drops[i].fall();
            drops[i].small();
          } else {
            noFill();
            drops[i].fall();
            drops[i].show();
          }
        }
      }
    }
  }
}

boolean inContour(float x, float y, Contour c) {
  Point p = new Point(x, y);
  MatOfPoint2f m = new MatOfPoint2f(c.pointMat.toArray());
  double r = Imgproc.pointPolygonTest(m, p, false);
  return r == 1;
}