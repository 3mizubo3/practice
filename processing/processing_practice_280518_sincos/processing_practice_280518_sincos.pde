int NUM = 512;

void setup(){
  size(640, 580);
  colorMode(HSB,120, 206, 256);
  noStroke();
  //background(0);
  frameRate(60);
  
  for (int i = 0; i < 2200; i++) {
  pushMatrix();
  translate(random(width), random(height));
  rotate(random(PI/2));
  scale(random(5, 20));
  fill(random(60, 100), 200, 70, 10);
  ellipse(0, 0, 10, 10);
  popMatrix();
}
}

float inc = 0.0;

float a = 0.0;
float b = 0.0;
float c = 0.0;

float ar = 0.0;
float br = 0.0;
float cr = 0.0;

void draw(){
   
  // blendMode(BLEND);
  fill(200);
  rect(0,0,width,height);
  // blendMode(ADD);
  
  translate(width / 2, height / 2);
  
  drawParticleAndPath(color(60, 120, 255, 8), color(255, 0, 0), a, ar);
  drawParticleAndPath(color(60, 50, 255, 10), color(0, 255, 0), b, br);
  drawParticleAndPath(color(40, 20, 255, 10), color(0, 0, 255), c, cr);
  
  a += .05;
  b += .05;
  c += .05;
  
  ar += 0.0015625*2;//pi/2の１００分の１
  br += 0.0015625;
  cr += 0.0015625;
  
  inc += 0.0015625;
}

void drawParticleAndPath(color cb, color ca, float ra, float rb) {  
  rotate(rb*2);
  
  // draw the path
  for(int i = 0; i < NUM; i++){
    float angle = i * TWO_PI / NUM;
    float v = pow(abs(sin(angle / 5)), 3);
    float r = map(v, 0, 1, 0.0, 10);
    fill(cb);
    ellipse((200 * cos(a)) / 30, 200 * sin(angle), r/10,r);
    ellipse(((200 * cos(a)) / 30)+30, 200 * sin(angle), r/10,r);
    //ellipse(((20 * cos(a)) / 30)+30, (20 * sin(angle))+10, r/10,r);
    //ellipse(100+(300 * cos(2*a)) / 30, 100+300 * sin(angle), r/10/50, r/50);
  }
  
   for(int i = 0; i < NUM; i++){
    float angle = i * TWO_PI / NUM;
    float v = pow(abs(sin(angle / 5)), 3);
    float r = map(v, 0, 1, 0.0, 10);
    fill(cb);
    ellipse((20 * cos(3*a)) / 30, (20 * sin(angle)), r/5,r);
    translate(100,50);
    //ellipse(100+(300 * cos(2*a)) / 30, 100+300 * sin(angle), r/10/50, r/50);
  } 
 
  if(a >= TWO_PI) a = 0;
  
  // draw the moving particle
  float v = pow(abs(sin(ra/2)), 4);
  float r = map(v, 0, 1, 0.5, 10);
  fill(ca);
  //ellipse((150 * cos(a)) / 2, 150 * sin(a), r * 2, r * 2);
}
