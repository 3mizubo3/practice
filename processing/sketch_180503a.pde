int NUM= 10000;
float[] x = new float[NUM];
float[] y = new float[NUM];

void setup(){
size(800,600,P2D);
frameRate(100);
background(0);

for(int i=0; i<NUM; i++){
  x[i] = width / 2.0;
  y[i] = height / 2.0;
}
}

void draw(){
  stroke(255);
  noFill();
  blendMode(ADD);
  
  for(int i = 0; i < NUM; i++){
    point(x[i],y[i]);
    x[i] = x[i] + random(-5.0,5.0);
    y[i] = y[i] + random(-5.0,5.0);
  }
    blendMode(BLEND);
    fill(0,5);
    noStroke();
    rect(0,0,width,height);
    
 saveFrame("frames/line-####.tif");
  }
