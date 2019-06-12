
int x = 60;

// The statements in the setup() function 
// execute once when the program begins
void setup() {
  size(700, 360);  // Size must be the first statement
  stroke(255);     // Set line drawing color to white
  frameRate(1);

}

void draw() { 
  background(0); 
    //text("M4", 20, 30, 50, 50);
  text("M3", 20, 60, 50, 50);
  text("M2", 20, 90, 50, 50);
  text("M1", 20, 120, 50, 50);
  text("M", 20, 150, 50, 50);
  text("m1", 20, 180, 50, 50);
  text("m2", 20, 210, 50, 50);
  text("m3", 20, 240, 50, 50);
  stroke(255);
  //for (int i = 60; i < 640; i = (i+(640/1))) {
  //  line(i, 30, i, 50);
  //}
  for (int i = 60; i < 640; i = (i+(640/2))) {
    line(i, 60, i, 80);
  }
  for (int i = 60; i < 640; i = (i+(640/4))) {
    line(i, 90, i, 110);
  }
  for (int i = 60; i < 640; i = (i+(640/8))) {
    line(i, 120, i, 140);
  }
  for (int i = 60; i < 640; i = (i+(640/16))) {
    line(i, 150, i, 170);
  }
  for (int i = 60; i < 640; i = (i+(640/32))) {
    line(i, 180, i, 200);
  }
  for (int i = 60; i < 640; i = (i+(640/64))) {
    line(i, 210, i, 230);
  }
  for (int i = 60; i < 640; i = (i+(640/128))) {
    line(i, 240, i, 260);
  }

  x = x + (640/16); // 16 is M 32 is m1
  if (x > 640) { 
    x = 60;
  } 
  stroke(0, 0, 255);
  line(x, 170, x, 150);
} 
