int radius = 200;
int precision = 800;
int points_per_circle = 500;
float speed = 0.1;
float ease_factor_red = 0.1;
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
float ease_factor;
int arc_length;


void setup(){
  colorMode(RGB);
  background(40);
  strokeWeight(8);
  blendMode(ADD);
  size(1024, 768);
  smooth(8);
  x = new float[precision];
  y = new float[precision];
}

void draw(){
  background(40);
  set_color("red");
  arc_calculate();
  calculate();
  plot();
  set_color("green");
  arc_calculate();
  calculate();
  plot();
  set_color("blue");
  arc_calculate();
  calculate();
  plot();
}

void arc_calculate(){
  hard_start = int(points_per_circle*((float)mouseX/width));
  hard_end = int(points_per_circle*((float)mouseY/height));
  
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
}

void calculate(){
  arc_length = end - start;
  for (int i = 0; i < arc_length; i++){
    t = ((float)TWO_PI/points_per_circle)*i;
    x[i] = width/2+(radius+sin(freq*t+speed*frameCount)*amp)*(sin(t+TWO_PI*(float)start/points_per_circle));
    y[i] = height/2+(radius+sin(freq*t+speed*frameCount)*amp)*(cos(t+TWO_PI*(float)start/points_per_circle));
  }
}


void set_color(String colour){
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
}
 
void plot(){
  freq = 12/abs((float)(end-start)/precision+0.5);
  amp = 50/abs((float)10*(end-start)/precision+0.5);
  
  for (int i = 1; i < arc_length; i++){
    line(x[i-1], y[i-1], x[i], y[i]);
 }

}