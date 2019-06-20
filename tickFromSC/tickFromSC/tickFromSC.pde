import oscP5.*;
import netP5.*;
import processing.serial.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

String tick = "tick";
String oldTick = "oldTick";

void setup() {
   oscP5 = new OscP5(this, 12000); 
}

void draw() {
  int m = millis();
  background(0);
 
 if(tick==oldTick) {ellipse(width/2,height/2,10,10); fill(0); } 
 else { ellipse(width/2,height/2,10,10); fill(250);   }
 
 tick = oldTick;
 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/tick")==true) {
    theOscMessage.print();
     println(theOscMessage.addrPattern());
    tick = theOscMessage.get(0).stringValue();
  }
}
