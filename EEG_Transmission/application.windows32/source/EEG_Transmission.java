import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import AULib.*; 
import oscP5.*; 
import netP5.*; 
import processing.net.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class EEG_Transmission extends PApplet {



/**
 *modified by origina file 
 oscP5message by andreas schlegel
 * example shows how to create osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 



Server myServer,myServer2,myServer3,myServer4;
OscP5 oscP5;
NetAddress myRemoteLocation;
int s1;
int s2;
int s3;
int s4;
byte k1;
byte k2;
byte k3;
byte k4;


public void setup() {
  size(400,400);
  frameRate(25);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,5000);
  
  //**Server implementation
  size(200, 200);
  // Starts a myServer on port 5204
  myServer = new Server(this, 5204); 
  myServer2 = new Server(this, 5205);
  myServer3 = new Server(this, 5206);
  myServer4 = new Server(this, 5207);
 
  
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
// myRemoteLocation = new NetAddress("127.0.0.1",12000);
}


public void draw() {
  background(0);  
}

public void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  OscMessage myMessage = new OscMessage("/test");
  
  myMessage.add(123); /* add an int to the osc message */
  myMessage.add(12.34f); /* add a float to the osc message */
  myMessage.add("some text"); /* add a string to the osc message */
  myMessage.add(new byte[] {0x00, 0x01, 0x10, 0x20}); /* add a byte blob to the osc message */
  myMessage.add(new int[] {1,2,3,4}); /* add an int array to the osc message */

  /* send the message */
  //oscP5.send(myMessage, myRemoteLocation); 
}


/* incoming osc message are forwarded to the oscEvent method. */
public void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
 //print("### received an osc message.");
  if (theOscMessage.checkAddrPattern("/muse/eeg") == true)
  {
    
   // println(" addrpattern: "+theOscMessage.addrPattern());
 

    //println (theOscMessage.get(0).floatValue());
    // println (theOscMessage.get(1).floatValue());
     // println (theOscMessage.get(2).floatValue());
     //  println (theOscMessage.get(3).floatValue());
       
       s1 = round(theOscMessage.get(0).floatValue());
       s2 = round(theOscMessage.get(1).floatValue());
       s3 = round(theOscMessage.get(2).floatValue());
       s4 = round(theOscMessage.get(3).floatValue());
 
    //Convert the data to binary
        k1 = PApplet.parseByte(s1);
        k2 = PApplet.parseByte(s2);
        k3 = PApplet.parseByte(s3);
        k4 = PApplet.parseByte(s4);
        
       //println(k1);
      s1 = s1/7;
      s2 = s2/7;
      s3 = s3/7;
      s4 = s4/7;
      //send different EEG valeus from different channels to different port 
   myServer.write(s1);
    myServer2.write(s2);
    myServer3.write(s3);
    myServer4.write(s4);
    
     
  
 
 //
  }
  //print(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "EEG_Transmission" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
