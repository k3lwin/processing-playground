int radius = 200;
int precision = 500;
float speed = 0.1;
float ease_factor_red = 0.05;
float ease_factor_green = 0.01;
float ease_factor_blue = 0.005;

float t;
float[] x;
float[] y;
float amp;
float freq;
float angle;
int start = 1;
int end = precision;
int hard_start;
int hard_end;
int delta_start;
int delta_end;


void setup(){
  colorMode(RGB);
  background(40);
  strokeWeight(5);
  blendMode(ADD);
  size(1024, 768);
  smooth(8);
  x = new float[precision];
  y = new float[precision];
}
void draw(){
  background(40);
  calculate();
  plot("red");
  plot("green");
  plot("blue");
  }


void calculate(){
  t=0;
  for (int i = 0; i < precision; i++){
    t = (TWO_PI/precision)*i;
    x[i] = width/2+(radius+sin(freq*t+speed*frameCount)*amp)*(sin(t));
    y[i] = height/2+(radius+sin(freq*t+speed*frameCount)*amp)*(cos(t));
  }
}


void plot(String colour){
  float ease_factor;
  if(colour == "red"){
    ease_factor = ease_factor_red;
    stroke(255, 0, 0, 96);
   }
   else if (colour == "green"){
    ease_factor = ease_factor_green;
    stroke(0, 255, 0, 96);
   }
   else if (colour == "blue"){
    ease_factor = ease_factor_blue;
    stroke(0, 0, 255, 96);
   }
   else {
    ease_factor = ease_factor_red;
    stroke(255, 255, 255, 255);
   }
  
  hard_start = int(precision*((float)mouseX/width));
  hard_end = int(precision*((float)mouseY/height));
  
  if (hard_start > hard_end){
    int tmp = hard_start;
    hard_start = hard_end + 1;
    hard_end = tmp;
    }
  else {
    hard_start++;
    }
  
  delta_start = hard_start - start;
  start += delta_start * ease_factor;
  
  delta_end = hard_end - end;
  end += delta_end * ease_factor;
  
  freq = 12/abs((float)(end-start)/precision);
  amp = 50/abs((float)10*(end-start)/precision+0.5);
  
  for (int i = start; i < end; i++){
    line(x[i-1], y[i-1], x[i], y[i]);
 }

}