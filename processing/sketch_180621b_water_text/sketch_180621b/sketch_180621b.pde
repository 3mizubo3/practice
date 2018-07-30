color ELLIPSE_COLOR = color(0);
color LINE_COLOR = color(0, 125);
color PGRAPHICS_COLOR = color(0); 
int LINE_LENGTH = 25;
boolean reverseDrawing = false;

PGraphics pg;
PFont font;
//ArrayList<OneChr> chrs = new ArrayList<OneChr>();
ArrayList<Brush> brushes; 

void setup() {
  size(1100, 400, JAVA2D);
  background(0);
  smooth();
  //font = loadFont("Arial-BoldMT-48.vlw");
  //blendMode(ADD);
  
  // create and draw to PPraphics (see Getting Started > UsingPGraphics example)
  pg = createGraphics(width, height, JAVA2D);
  pg.beginDraw();
//  pg.textFont(font);
  pg.textSize(300);
  pg.textAlign(CENTER, CENTER);
  pg.fill(PGRAPHICS_COLOR);
  pg.text("WATER", pg.width/2, pg.height/2); 
  pg.endDraw();


  brushes = new ArrayList<Brush>();
  //for (int i = 0; i < 50; i++) {
    //brushes.add(new Brush());
  //}
  
}

void draw() {

  fill(255);
  stroke(0);
  textAlign(CENTER, CENTER);
   
   if(brushes.size() < 500){
  for (int i=0; i<60; i++) {
    float x = random(width);
    float y = random(height);
    color c = pg.get( int(x), int(y) );
    if ( c == PGRAPHICS_COLOR ) {
        brushes.add(new Brush(x,y));
    }
  }
   }
  
  for (Brush brush : brushes) {
    brush.paint();
  }
  
}

class Brush {
  float angle;
  int components[];
  float x, y;
  color clr;
  color coll;
  float brightness;
  float u;

  Brush(float _x, float _y) {
    angle = random(TWO_PI);
    x = _x;
    y = _y;
    u = random(0.5, 1);
    clr = color(random(255), random(255), random(255), 255);
    //coll = img.get(int(x), int(y));
    components = new int[2];
    for (int i = 0; i < 2; i++) {
      components[i] = int(random(1, 5));
    }
  }

  void paint() {
    float a = 0;
    float r = 0;
    float x1 = x;
    float y1 = y;
    float u = random(0.5, 1);
    float myNoise;

    fill(clr,5);
    noStroke();    

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.85, 1);
      x1 = x + r* cos(angle + a)* u* v;
      y1 = y + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 2; i++) {
        r += 0.22*sin(a * components[i]);
      }
    }
    endShape(CLOSE);

   // if (x < 0 || x > width ||y < 0 || y > height) {
   //   angle += HALF_PI;
   // }
   angle += -HALF_PI;
   
    //myNoise  = map(noise(frameRate),0,1,0.98,1.02);
    x = x+0.7*cos(frameRate);
    y = y+0.7*sin(frameRate);
    //angle += random(-0.15, 0.15);
    //coll = img.get(int(x), int(y));
    //brightness  = red(coll) + green(coll) + blue(coll);
    //u = map(brightness, 0, 255*3, 0.3, 0.7);
  }
}
