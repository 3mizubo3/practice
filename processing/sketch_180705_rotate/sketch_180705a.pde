int rows = 3, cols = 4;
float edge, cellSize;
color[] palette = {#0063cd, #00bd3a, #ffaf18, #ff1935 };
float incr;
float m=1;
boolean spiral = true;
int drawFrame=0;
void setup() {
  size(800, 600);
  edge = 50;
  cellSize = (width-2*edge)/cols;
  //noStroke();
  run();
colorMode(HSB, 360, 100, 100);
}

void draw() {
    background(360, 0, 100);
  drawStuff(true);
}

void drawStuff(boolean white) {
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      float x = edge + (i+.5)*cellSize;
      float y = edge + (j+.5)*cellSize;
      stroke(360-(drawFrame/10 % 360), 100,100,360);
      //strokeWeight(2);
      fill(drawFrame/10 % 360, 100,100,100);
      /*if (white) {
        fill(255);
      } else {
        fill(palette[int(random(palette.length))]);
      }*/
      //stroke(255);
      //noStroke();
      m=-m;
      createThing(x, y,m);
        drawFrame++;
    }
  }
}

void run() {
  background(255);
  drawStuff(true);
  drawStuff(false);
}

void mouseReleased() {
  run();
}

void mousePressed(){
  spiral = !spiral;
}

void keyPressed() {
  //save(random(12343)+".png");
}

void createThing(float x, float y,float m) {
  pushMatrix();
  translate(x, y);
  //beginShape();
  //vertex(0, 0);
  
  for (int i=0; i<20; i++) {
    //fill(255);
    //bezierVertex(genPoint()+sin(frameCount), genPoint(), genPoint(), genPoint(), genPoint(), genPoint());
    bezier(70, 54, 180*sin(m*incr*10), 141*cos(incr*10), 43, 10, 29, 30);
    rotate(m*incr);
    if (spiral) scale(1, 0.98);
    //bezier(140, 34, 200, 141, 33*sin(incr*10), 10*cos(incr*10), 49, 91);
  }
  //endShape(CLOSE);
  incr +=  .0007;

  popMatrix();
}

float genPoint() {
  float sz = cellSize*.45;
  //float r = noise(random(-sz, sz);
  float r = -sz*noise(random(10))+sz*noise(random(10));
  return r;
}


//translate(width/2, height/2);

/*  for (var i = 0; i < 84; i++) {
    fill(color[i%7]);
    bezier(140, 34, 200*sin(incr*10), 141*cos(incr*10), 33, 10, 49, 91);
    rotate((incr));
    if (spiral) scale(1, 0.984);*/

  
  //pop();
