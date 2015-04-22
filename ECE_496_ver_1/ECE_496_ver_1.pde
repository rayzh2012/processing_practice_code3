import matlabcontrol.*;
import matlabcontrol.extensions.*;
import matlabcontrol.internal.*;
import processing.core.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import java.util.*;
import processing.serial.*; //import the Serial library
// import libraries
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*; // http://www.sojamo.de/libraries/controlP5/
import processing.serial.*;
import matlabcontrol.*;
import matlabcontrol.extensions.*;
import matlabcontrol.internal.*;
import processing.core.*;
import oscP5.*;
import netP5.*;
import processing.net.*;
import java.util.*;
import processing.serial.*; //import the Serial library
// Serial myPort;  //the Serial port object
 //String val;
// since we're doing serial handshaking, 
// we need to check if we've heard from the microcontroller
//boolean firstContact = false;
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

  double[][] input = new double[43][1];

  double s1;//blink
  double s2;//concentration
  double s3;//mellow
  public boolean isDrowsy = false;
  
  float alert;
  float drowsy; 


  /* SETTINGS BEGIN */

// Serial port to connect to
String serialPortName = "/dev/tty.usbmodem1411";

// If you want to debug the plotter without using a real serial port set this to true
boolean mockupSerial = true;

/* SETTINGS END */

Serial serialPort; // Serial port object

// interface stuff
ControlP5 cp5;


byte[] inBuffer = new byte[100]; // holds serial message
int i = 0; // loop variable
//ControlFrame cf;

// Settings for the plotter are saved in this file
JSONObject plotterConfigJSON;
 Chart myChart3;
// plots
Graph BarChart = new Graph(150, 100, 800, 250, color(20, 20, 200));
Graph LineGraph = new Graph(150, 500, 600, 250, color (20, 20, 200));
Graph Drowsy_meter = new Graph (875,500,200,250, color(250,0,0));
float[] barChartValues = new float[8];
float[][] lineGraphValues = new float[8][100];
float[] lineGraphSampleNumbers = new float[100];
color[] graphColors = new color[8];

// helper for saving the executing path
String topSketchPath = "";
 String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
 
 
  public  void setup() {
    
   
  //  initialize your serial port and set the baud rate to 9600
   
   // println(Serial.list()[0]);
  //   println(Serial.list()[0]);
    myPort = new Serial(this, portName, 9600);
    oscP5 = new OscP5(this,5000,OscP5.TCP);
    
    //graphical Interface
     frame.setTitle("ECE496 RealTime Health Analysis");
  size(1300, 900);
  frameRate(25);
    if (frame != null) {
    frame.setResizable(true);
  }
  // set line graph colorsgraphColors
  graphColors[0] = color(0,0,255);
  graphColors[1] = color(0,0,5);
  graphColors[2] = color(223,100,100);
  graphColors[3] = color(100,100,100);
  graphColors[4] = color(0,255,255);
  graphColors[5] = color(255,0,255);
  graphColors[6] = color(255,255,0);
  graphColors[7] = color(0,255,0);
 // graphColors[8] = color(232, 158, 12);
 // graphColors[8] = color(255, 0, 0);
 // graphColors[9] = color(62, 12, 232);

   String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
    myPort = new Serial(this, portName, 9600);
    oscP5 = new OscP5(this,5000,OscP5.TCP);


  // settings save file
  topSketchPath = sketchPath;
  plotterConfigJSON = loadJSONObject(topSketchPath+"/plotter_config.json");

  // gui
  cp5 = new ControlP5(this);
  
 
  smooth();
  cp5 = new ControlP5(this);
  cp5.addButton("hello")
     .setPosition(1100, 100)
     .setSize(100,100)
     .setView(new CircularButton())
     ;
     
  cp5.addButton("world")
     .setPosition(1100, 250)
     .setSize(100,100)
     .setView(new CircularButton())
     ;
     //drowsiness meter
  //cp5.printPublicMethodsFor(Chart.class);
//myChart3 = cp5.addChart("drowsy5")
  //             .setPosition(875, 500)
    //          .setSize(200, 250)
      //         .setRange(-20, 20)
        //       .setView(Chart.BAR_CENTERED)
          //     ; // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
                 
                
            //     myChart3.addDataSet("drowsy5");
              //   myChart3.setColors("drowsy5", color(255,0,255), color(0, 255, 0));
                //  myChart3.setData("drowsy5", new float[8]);
                  //myChart3.setStrokeWeight(1.5);
                  
                  
                   
  // extra control panel frame
  //cf = addControlFrame("Robot Tuner", 500, 650);
  
  // init charts
  setChartSettings();
  for (int i=0; i<barChartValues.length; i++) {
    barChartValues[i] = 0;
  }
  // build x axis values for the line graph
  for (int i=0; i<lineGraphValues.length; i++) {
    for (int k=0; k<lineGraphValues[0].length; k++) {
      lineGraphValues[i][k] = 0;
      if (i==0)
        lineGraphSampleNumbers[k] = k;
    }
  }
  
  // start serial communication
  if (!mockupSerial) {
    //String serialPortName = Serial.list()[3];
    serialPort = new Serial(this, serialPortName, 115200);
  }
  else
    serialPort = null;

  // build the gui
  int x = 50;
  int y = 50;
 // cp5.addTextfield("bcMaxY").setPosition(x, y).setText(getPlotterConfigString("bcMaxY")).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("bcMinY").setPosition(x, y=y+250).setText(getPlotterConfigString("bcMinY")).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMaxY").setPosition(x, y=y+200).setText(getPlotterConfigString("lgMaxY")).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMinY").setPosition(x, y=y+250).setText(getPlotterConfigString("lgMinY")).setWidth(40).setAutoClear(false);

 // cp5.addTextlabel("on/off2").setText("on/off").setPosition(x=13, y=20).setColor(0);
 // cp5.addTextlabel("multipliers2").setText("on/off").setPosition(x=55, y).setColor(0);
 // cp5.addTextfield("bcMultiplier1").setPosition(x=60, y=30).setText(getPlotterConfigString("bcMultiplier1")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("bcMultiplier2").setPosition(x, y=y+40).setText(getPlotterConfigString("bcMultiplier2")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("bcMultiplier3").setPosition(x, y=y+40).setText(getPlotterConfigString("bcMultiplier3")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("bcMultiplier4").setPosition(x, y=y+40).setText(getPlotterConfigString("bcMultiplier4")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("bcMultiplier5").setPosition(x, y=y+40).setText(getPlotterConfigString("bcMultiplier5")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("bcMultiplier6").setPosition(x, y=y+40).setText(getPlotterConfigString("bcMultiplier6")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
 // cp5.addToggle("bcVisible1").setPosition(x=60, y=30).setValue(int(getPlotterConfigString("bcVisible1"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[0]);
  //cp5.addToggle("bcVisible2").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible2"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[1]);
  //cp5.addToggle("bcVisible3").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible3"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[2]);
  //cp5.addToggle("bcVisible4").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible4"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[3]);
  //cp5.addToggle("bcVisible5").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible5"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[4]);
  //cp5.addToggle("bcVisible6").setPosition(x=x-50, y=30).setValue(int(getPlotterConfigString("bcVisible6"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[5]);
  //cp5.addToggle("bcVisible7").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible1"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[6]);
 //cp5.addToggle("bcVisible8").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible2"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[7]);
 // cp5.addToggle("bcVisible9").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible3"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[7]);
  // cp5.addToggle("bcVisible10").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("bcVisible3"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[0]);



 // cp5.addTextlabel("label").setText("on/off").setPosition(x=13, y=y+90).setColor(0);
 // cp5.addTextlabel("multipliers").setText("multipliers").setPosition(x=55, y).setColor(0);
  //cp5.addTextfield("lgMultiplier1").setPosition(x=60, y=y+10).setText(getPlotterConfigString("lgMultiplier1")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMultiplier2").setPosition(x, y=y+40).setText(getPlotterConfigString("lgMultiplier2")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMultiplier3").setPosition(x, y=y+40).setText(getPlotterConfigString("lgMultiplier3")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMultiplier4").setPosition(x, y=y+40).setText(getPlotterConfigString("lgMultiplier4")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMultiplier5").setPosition(x, y=y+40).setText(getPlotterConfigString("lgMultiplier5")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addTextfield("lgMultiplier6").setPosition(x, y=y+40).setText(getPlotterConfigString("lgMultiplier6")).setColorCaptionLabel(0).setWidth(40).setAutoClear(false);
  //cp5.addToggle("lgVisible1").setPosition(x=x-50, y=330).setValue(int(getPlotterConfigString("lgVisible1"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[0]);
  //cp5.addToggle("lgVisible2").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("lgVisible2"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[1]);
  //cp5.addToggle("lgVisible3").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("lgVisible3"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[2]);
  //cp5.addToggle("lgVisible4").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("lgVisible4"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[3]);
  //cp5.addToggle("lgVisible5").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("lgVisible5"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[4]);
  //cp5.addToggle("lgVisible6").setPosition(x, y=y+40).setValue(int(getPlotterConfigString("lgVisible6"))).setMode(ControlP5.SWITCH).setColorActive(graphColors[5]);
  
      
  }
  
  void draw() {
  /* Read serial and update values */
  if (mockupSerial || serialPort.available() > 0) {
    String myString = "";
    if (!mockupSerial) {
      try {
        serialPort.readBytesUntil('\r', inBuffer);
      }
      catch (Exception e) {
      }
      myString = new String(inBuffer);
    }
    else {
      myString = mockupSerialFunction();
    }

    //println(myString);

    // split the string at delimiter (space)
    String[] nums = split(myString, ' ');
    
    // count number of bars and line graphs to hide
    int numberOfInvisibleBars = 0;
    for (i=0; i<8; i++) {
      if (int(getPlotterConfigString("bcVisible"+(i+1))) == 0) {
        numberOfInvisibleBars++;
      }
    }
    int numberOfInvisibleLineGraphs = 0;
    for (i=0; i<8; i++) {
      if (int(getPlotterConfigString("lgVisible"+(i+1))) == 0) {
        numberOfInvisibleLineGraphs++;
      }
    }
    // build a new array to fit the data to show
    barChartValues = new float[8-numberOfInvisibleBars];

    // build the arrays for bar charts and line graphs
    int barchartIndex = 0;
    for (i=0; i<nums.length; i++) {

      // update barchart
      try {
        if (int(getPlotterConfigString("bcVisible"+(i+1))) == 1) {
          if (barchartIndex < barChartValues.length)
            barChartValues[barchartIndex++] = float(nums[i])/**float(getPlotterConfigString("bcMultiplier"+(i+1)))*/;
        }
        else {
        }
      }
      catch (Exception e) {
      }

      // update line graph
      try {
        if (i<lineGraphValues.length) {
          for (int k=0; k<lineGraphValues[i].length-1; k++) {
            lineGraphValues[i][k] = lineGraphValues[i][k+1];
          }

          lineGraphValues[i][lineGraphValues[i].length-1] = float(nums[i])*float(getPlotterConfigString("lgMultiplier"+(i+1)));
        }
      }
      catch (Exception e) {
      }
    
    }
      
  }

  // draw the bar chart
  background(255); 
  BarChart.DrawAxis();              
  BarChart.Bar(barChartValues); // This draws a bar graph of Array4
  Drowsy_meter.DrawAxis();
  Drowsy_meter.Bar(barChartValues,0,1);
  // draw the line graphs
  LineGraph.DrawAxis();
  for (int i=0;i<lineGraphValues.length; i++) {
    LineGraph.GraphColor = graphColors[i];
    if (int(getPlotterConfigString("lgVisible"+(i+1))) == 1)
      LineGraph.LineGraph(lineGraphSampleNumbers, lineGraphValues[i]);
    //  myChart3.getColor().setBackground(color(255, 100));
     // myChart3.updateData("drowsy5", barChartValues);//
      // myChart3.unshift("drowsy5", (sin(frameCount*0.05)*10)); 
  }
  
  

//catch (Exception e){}
  
  
  
}

  
  // called each time the chart settings are changed by the user 
void setChartSettings() {
  BarChart.xLabel="Emotion Spectrum";
  BarChart.yLabel="Percentage (%)";
  BarChart.Title="Emotion Spectrum Meter";  
  BarChart.xDiv=1;  
  BarChart.yMax=int(getPlotterConfigString("bcMaxY")); 
  BarChart.yMin=int(getPlotterConfigString("bcMinY"));

  LineGraph.xLabel=" Samples ";
  LineGraph.yLabel="EEG Singals (μV)";
  LineGraph.Title="";  
  LineGraph.xDiv=20;  
  LineGraph.xMax=0; 
  LineGraph.xMin=-100;  
  LineGraph.yMax=int(getPlotterConfigString("lgMaxY")); 
  LineGraph.yMin=int(getPlotterConfigString("lgMinY"));
  
  Drowsy_meter.xLabel="";
  Drowsy_meter.yLabel = "Percentage (%)";
  Drowsy_meter.Title="Drowsy Meter";
  Drowsy_meter.xDiv=1;
  Drowsy_meter.yMax=200; 
  Drowsy_meter.yMin=0;  
  



}

// handle gui actions
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class) || theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Button.class)) {
    String parameter = theEvent.getName();
    String value = "";
    if (theEvent.isAssignableFrom(Textfield.class))
      value = theEvent.getStringValue();
    else if (theEvent.isAssignableFrom(Toggle.class) || theEvent.isAssignableFrom(Button.class))
      value = theEvent.getValue()+"";

    plotterConfigJSON.setString(parameter, value);
    saveJSONObject(plotterConfigJSON, topSketchPath+"/plotter_config.json");
  }
  setChartSettings();
}

// get gui settings from settings file
String getPlotterConfigString(String id) {
  String r = "";
  try {
    r = plotterConfigJSON.getString(id);
  } 
  catch (Exception e) {
    r = "";
  }
  return r;
}


  
  
  //create the options of the proxy
     public MatlabProxyFactoryOptions options = new MatlabProxyFactoryOptions.Builder()
    .setUsePreviouslyControlledSession(true)
    .setPort(6000)
     .build();
      //create the factory of proxies
    public MatlabProxyFactory factory = new MatlabProxyFactory(options);
  
  
public  void oscEvent(OscMessage theOscMessage) throws MatlabConnectionException, MatlabInvocationException  {
     
   

   MatlabProxy proxy = factory.getProxy();
  // println(proxy.isExistingSession());
    
    
  /* print the address pattern and the typetag of the received OscMessage */
     //print("### received an osc message.");
      if (theOscMessage.checkAddrPattern("/muse/elements/alpha_absolute") == true)
      {
         //s1 = 0;
        for (int i=0 ; i<4; i++)   
         {
           f1[i] = (theOscMessage.get(i).floatValue());
      
           
         }

        
      }
      
      /////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/alpha_relative") == true)
      {
         //s1 = 0;
        for (int i=0 ; i<4; i++)   
         {
           f2[i] = theOscMessage.get(i).floatValue();
         }

        
      }
      //////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/beta_absolute") == true)
      {
         //s1 = 0;
        for (int i=0 ; i<4; i++)   
         {
           f3[i] = theOscMessage.get(i).floatValue();
         }

        
      }
      //////////////////////////////////////////////////////////////////////

      if (theOscMessage.checkAddrPattern("/muse/elements/beta_relative") == true)
      {
         for (int i=0 ; i<4; i++)   
         {
           f4[i] = theOscMessage.get(i).floatValue();
         }
      }
      
      //////////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/blink") == true)
      {
          s1 =theOscMessage.get(0).intValue();
      }
      
      //////////////////////////////////////////////////////////////////////////
      

      
      if (theOscMessage.checkAddrPattern("/muse/elements/delta_absolute") == true)
      {
          for (int i=0 ; i<4; i++)   
         {
           f5[i] = theOscMessage.get(i).floatValue();
         }  
       
      }
      ////////////////////////////////////////////////////////////////////////////
      
       
        if (theOscMessage.checkAddrPattern("/muse/elements/delta_relative") == true)
      {
          for (int i=0 ; i<4; i++)   
         {
           f6[i] = theOscMessage.get(i).floatValue();
         }  
       
      }
      //////////////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/experimental/concentration") == true)
       {
            s2 = theOscMessage.get(0).floatValue();
       }
       ////////////////////////////////////////////////////////////////////////////////
       
        if (theOscMessage.checkAddrPattern("/muse/elements/experimental/mellow") == true)
       {
            s3 = theOscMessage.get(0).floatValue();
       }
       /////////////////////////////////////////////////////////////////////////////////////
      
      if (theOscMessage.checkAddrPattern("/muse/elements/gamma_absolute") == true)
      {
             for (int i=0 ; i<4; i++)   
         {
           f7[i] = theOscMessage.get(i).floatValue();
         }
         
     }
     
        /////////////////////////////////////////////////////////////////////////////////////
          if (theOscMessage.checkAddrPattern("/muse/elements/gamma_relative") == true)
      {
             for (int i=0 ; i<4; i++)   
         {
           f8[i] = theOscMessage.get(i).floatValue();
         }
        
     }
     
        /////////////////////////////////////////////////////////////////////////////////////
       if (theOscMessage.checkAddrPattern("/muse/elements/theta_absolute") == true)
      {
           for (int i=0 ; i<4; i++)   
         {
           f9[i] = theOscMessage.get(i).floatValue();
         }
       
      }
     
      if (theOscMessage.checkAddrPattern("/muse/elements/theta_relative") == true)
      {
           for (int i=0 ; i<4; i++)   
         {
           f10[i] = theOscMessage.get(i).floatValue();
           
         }
        
     
      }
     
     ////construct the input array
      for (int i =0; i<4;i++)
      {
        input[i][0] = f1[i]; // alpha absolute
        input[i+4][0] = f2[i];// alpha relative
        input[i+8][0] = f3[i]; // beta absolute
        input[i+12][0] = f4[i];// beta relative
        input[16][0] = s1; //blink
        input[i+17][0] = f5[i];// delta_absolute
        input[i + 21][0]= f6[i];// delta_relative
        input[25][0]= s2;//concentration
        input[26][0]=s3; //mellow
        input[i+27][0] = f7[i]; //gamma_ab
        input[i+31][0] = f8[i]; //gamma real
        input[i+35][0] = f9[i];//theta/ab
        input[i+39][0] = f10[i]; //theta_relative
        
      }
     // for (int i =0;i<43;i++)
     // {
     //println(input[i][0]);
     // }
    

     //Send the array to MATLAB, transpose it, then retrieve it and convert it to a 2D double array
      MatlabTypeConverter processor = new MatlabTypeConverter(proxy);
       processor.setNumericArray("array", new MatlabNumericArray(input, null));
       proxy.eval("array = array';");
       proxy.eval("array = a(array);");
    
       double[][] javaArray = processor.getNumericArray("array").getRealArray2D();
        System.out.println("Alert: " + javaArray[0][0]*100 + "  Drowsy "+ javaArray[1][0]*100 + "%");
        
         alert = (float) javaArray[0][0];
         drowsy = (float) javaArray[1][0];
        
        if (alert<0.5)
        {
          isDrowsy=true;
        }
        else
        isDrowsy = false;

      //Disconnect the proxy from MATLAB
        proxy.disconnect();
      
       // println(isDrowsy);
     
    }
    



 
