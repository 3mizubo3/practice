int NUM = 10000;
float [] x = new float[NUM];
float [] y = new float[NUM];

void setup(){
  size(800,600,P2D);
  frameRate(40);
  background(0);
  
  for(int i = 0; i<NUM; i++){
    x[i]=random(width);
    y[i]=random(height);
  }
}

void draw(){
  blendMode(ADD);
  stroke(63);
  noFill();
  
for(int i =0; i<NUM; i++){
  point(x[i], y[i]);
  x[i]=x[i]+random(-5.0,1.5);
  y[i]=y[i]+random(-1.0,5.0);

if(x[i]<0){
  x[i]=width;
}
if(x[i]>width){
  x[i]=0;
}
if(y[i]<0){
  y[i]=height;
}
if(y[i]>height){
  y[i]=0;
}
}
blendMode(BLEND);
noStroke();
fill(0,3);
rect(0,0,width,height);

saveFrame("frames/line-####.tif");
}
