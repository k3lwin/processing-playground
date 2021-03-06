float fluorescence = 10;
int coil_voltage = 300;
int precision = 100;
float speed_factor = 10;

float[] x = new float[precision];
float[] y = new float[precision];
float old_x;
float old_y;

void setup(){
  colorMode(RGB);
  background(0);
  strokeWeight(4);
  blendMode(BLEND);
  size(1024, 768);
  smooth(8);
  
  x[precision-1] = width/2;
  y[precision-1] = height/2;
  
}

void draw(){
  noStroke();
  fill(0, 0, 0, (255*1/fluorescence));
  rect(0, 0, width, height);
  
  stroke(0, 255, 0, 255);
  
  old_x = x[precision-1];
  old_y = y[precision-1];
  
  float t = (frameCount*speed_factor);
  println(t);
  for (int i = 0; i < precision; i++){
    
    float step = (float)i*speed_factor/precision;
    
    x[i] = width/2+coil_voltage*sin((float)mouseX/width*(t+step));
    y[i] = height/2+coil_voltage*sin((float)mouseY/height*(t+step));
    
    println(i, x[i], y[i]);
  }
  
  line(old_x, old_y, x[0], y[0]);
  for (int i = 1; i < precision; i++){
    line(x[i-1], y[i-1], x[i], y[i]);
  }
}