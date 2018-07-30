final float ELLIPSE_MULT_MIN = 1; // min size multiplier for ellipse
final float ELLIPSE_MULT_MAX = 200; // max size multiplier for ellipse
final float ELLIPSE_BASE_W = 3; // ellipse base width
final float ELLIPSE_BASE_H = 1; // ellipse base height
final int ELLIPSE_XOFF = -60; // ellipse x-offset from centre of sketch
final int ELLIPSE_YOFF = -60; // ellipse y-offset from centre of sketch
final float ELLIPSE_PERIOD = TWO_PI / 1080; // period of sine wave governing ellipse size
final float SKETCH_ROT = TWO_PI / 600; // speed at which sketch canvas rotates
final int BACKLIGHT = 16; // background brightness value

boolean drawMe = true; // for pause/resume
int drawFrame = 0; // pause/resume ability means we can't use frameCount

void setup() {
  frameRate(60);
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  background(0,0,BACKLIGHT,100);
  noFill();
  strokeWeight(1);
}

void draw() {
  if (drawMe) {
    float x = drawFrame * ELLIPSE_PERIOD;//n/600*2pi
    x -= HALF_PI; // start at sin(x) = 0
    float amplitude = ELLIPSE_MULT_MAX - ELLIPSE_MULT_MIN;//200-1=199
    float ellipseMult = (sin(x) * amplitude) / 2; // sine wave to control size of ellipse()
    ellipseMult += amplitude/2 + ELLIPSE_MULT_MIN; // ELLIPSE_MULT_MIN <= sine values <= ELLIPSE_MULT_MAX
    float w = ELLIPSE_BASE_W * ellipseMult;
    float h = ELLIPSE_BASE_H * ellipseMult;
    float c = 30*sin(x);
    
    pushMatrix();
    translate(width/2, height/2);
    rotate(drawFrame * SKETCH_ROT);
    
    stroke(c, 100,100,100); //stroke(200, 65, 80, 100); // use this for blue similar to https://gfycat.com/JointRealisticGrouper
    //ellipse(ELLIPSE_XOFF, ELLIPSE_YOFF, w, h);
    ellipse(h, h,-ELLIPSE_XOFF+10, -ELLIPSE_YOFF);
    popMatrix();
    
    drawFrame++;
  }
}

// press space to pause/resume
void keyPressed() {
  if (key == ' ') {
    drawMe = drawMe ? false : true; 
  }
}
