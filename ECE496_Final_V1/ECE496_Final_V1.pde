import matlabcontrol.*;
import matlabcontrol.extensions.*;
import matlabcontrol.internal.*;
import processing.core.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import java.util.*;
import processing.serial.*; //import the Serial library
 Serial myPort;  //the Serial port object
 String val;
// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
boolean firstContact = false;
//import main.m
  OscP5 oscP5;
  double[] f1 = new double[4];
  double[] f2 = new double[4];
  double[] f3 = new double[4];
  double[] f4 = new double[4];
  double[] f5 = new double[4];
  double[] f6 = new double[4];
  double[] f7 = new double[4];
  double[] f8 = new double[4];
  double[] f9 = new double[4];
  double[] f10 = new double[4];
  
  //initialize drowsiness meter
    double alert = 0;
    double  drowsy = 0;
  
 //import cp5 library
 import controlP5.*;
  ControlP5 cp5;
 
  //Plotting a circle
int cx, cy;
int segmentCount = 100;
int step = 0;
float plotDiameter, plotRadius, plotCircumference;

  double[][] input = new double[43][1];
  double s1;//blink
  double s2;//concentration
  double s3;//mellow
  public boolean isDrowsy = false;
  
  Textlabel title;
  
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
      double[][] javaArray = new double[2][43];
 
 //---------------------------------------------------------------------------------------------------------------------------------
// Declare classes
Graph myGraph;
int [][][] myDataSet; // [year][reason for removal from waiting list][organ]

// Define color palette
color colBack;
color colLines;
color colText;
color colTimeline;
color colOnGraph;

// Define global variables
int numYears; // number of years charted
int numReasons; // waiting list removal reasons
int numOrgans; // number of organ categories
boolean timelineDrag; // whether timeline is being dragged
boolean hoverReasons; // show reasons for removal overlay
PFont myFont;
PFont myFontB;
PFont myFontBB;

//********************************************************
void setup(){
  size(800,800);
     // cp5 = new ControlP5(this);
     println(Serial.list()[1]);
     println(Serial.list()[1]);
    myPort = new Serial(this, portName, 9600);
    oscP5 = new OscP5(this,5000,OscP5.TCP);
    
    
  // Define color palette
  colBack = color(255);
  colLines = color(255);
  colText = color(0);
  colTimeline = color(150);
  colOnGraph = color(255);
  
  // Initialize global variables
  numYears = 10;
  numReasons = 10;
  numOrgans = 5;
  timelineDrag = false;
  hoverReasons = false;
  
  // Define instances of classes
  myGraph = new Graph(numOrgans);
  myDataSet = new int[numYears][numReasons][numOrgans];
  
  // Import data
  String [ ] dataLines = loadStrings("OrganTransplantData.csv"); // each line of data
  String [ ] tempDataStrings = new String[numOrgans+2]; // each item of data per row, as a string (reason, year, 8 organs)
  int tempYearIndex;
  int tempReasonIndex;
  
  // Split each line into strings of data 
  for(int i=0; i<dataLines.length; i++){
    tempDataStrings = split(dataLines[i], ',');
    tempYearIndex = yearToIndex(int(tempDataStrings[1]));
    tempReasonIndex = reasonLineToIndex(i);
    
    // parse each line of data into the appropriate year, reason, and organ
    for(int j=2; j<tempDataStrings.length; j++){
      myDataSet[tempYearIndex][tempReasonIndex][j-2] = int(tempDataStrings[j]);
    }
  }

  // format text
  myFont = createFont("Archer-Book",12);
  myFontB = createFont("Archer-Semibold",12);
  myFontBB = createFont("Archer-Bold",12);
  textFont(myFont);
}
  


