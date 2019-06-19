
float a = 0;
float inc = 0.01;


// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(700, 360);  // Size must be the first statement
  stroke(255);     // Set line drawing color to white
  frameRate(60);

}

void draw() { 
  background(0); 
  line(0,150,width,150);
  for (int i = 1; i < 700; i = (i+(1))) {
    ellipse(20+(i), (250*(sin(a*i)*0.5))+150, 5, 5);
  }

  a = a + inc;
 
} 
