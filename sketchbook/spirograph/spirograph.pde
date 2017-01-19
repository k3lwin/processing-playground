float t;
float dt = 0.02;
int radius = 200;
float amp = 12;
float freq = 12;
int prescision = 10000;
float[] x;
float[] y;

void setup(){
  colorMode(RGB);
  background(200);
  size(1024, 768);
  smooth(8);
  x = new float[prescision];
  y = new float[prescision];
}

void draw(){
  background(200);
  amp = (height-mouseY)*0.5;
  freq = (width/2-mouseX)*0.5;
  calculate();
  for (int i = 1; i < prescision; i++){
    line(x[i-1], y[i-1], x[i], y[i]);
    point(x[i], y[i]);
  }

}

void calculate(){
  t = 0;
  for (int i = 0; i < prescision; i++){
    t = (2*PI/prescision)*i;
    x[i] = (-sin(freq*t)*amp+(width/2+sin(t)*radius));
    y[i] = (cos(freq*t)*amp+(height/2+cos(t)*radius));
  }
}