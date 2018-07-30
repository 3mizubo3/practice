PImage p;
ParticleSystem system;

color bg = color(0);

boolean trails = true;

//Particle image bounds. -1 for
//endX or endY means the width
//or height of the used image

int startX = 0, endX = -1;
int startY = 0, endY = -1;

//The skip variables work well when
//they're the same value as size

//Set xSkip, ySkip and particleSize to 1
//for a mostly perfect image, although
//this will be very demanding. Even
//setting them both to 2 can be dramatically
//easier to render.
int xSkip = 10;
int ySkip = 10;

float particleSize = 1;

boolean recording = false;

//If true, uses colours from the generated
//text image. Otherwise, uses particleColour
boolean imageColour = false;
color particleColour = color(255);

PImage generateTextImage(String text, float textSize) {
  PGraphics g = createGraphics(width, height);
  g.beginDraw();
  g.fill(255);
  g.textSize(textSize);
  float textHeight = g.textAscent() + g.textDescent();
  int newLines = floor(g.textWidth(text)/g.width) + text.split("\n").length;
  g.textAlign(CENTER);
  g.background(0);
  g.rectMode(CENTER);
  g.text(text, 400, 400, g.width, textHeight * 1.2 * max(1, newLines));
  g.endDraw();
  return g.get();
}

void setup() {
  size(800, 800);

  //Neither skip value can be 0 or at least
  //one of the loops will never stop
  if (xSkip <= 0) {
    xSkip = 1;
  }
  if (ySkip <= 0) {
    ySkip = 1;
  }
  noStroke();
  background(bg);
  //This can be an arbitrary image
  p = generateTextImage("ball", 300);
  system = new ParticleSystem(p);
}

void mouseReleased() {
  system.resetParticles();
}

void draw() {
  if (trails) {
    noStroke();
    fill(bg, 20);
    rectMode(CORNER);
    rect(0, 0, width, height);
    rectMode(CENTER);
  } else {
    background(bg);
  }
  //long t = millis();
  for (Particle p : system.particles) {
    p.update(1f/60);
    p.draw();
  }
  //println(millis() - t);
//  if (recording) {
//    saveFrame("frames/PIF-####.tif");
//  }
}

class Particle {
  PVector start, anchor, end;
  PVector current = new PVector();
  float f = 0;
  float size;
  float duration;
  color c;
  float r = 0;
  float r2 = 0;
  color c2= color(random(255), random(255), random(255), 7);
  float x1 =0;
  float y1=0;
  float a =0;
  //float u = random(0.6, 1);
  public Particle(float ex, float ey, float size, float d, color c) {
    this.start = new PVector(width/2, height/2);
    //float a = round(random(16)) * QUARTER_PI * 0.5;
    //this.anchor = new PVector(cos(a) * 300 + width/2, sin(a) * 300 +height/2);
    float a = random(TWO_PI);
    this.anchor = new PVector(cos(a) * random(100, 700) + width/2,sin(a) * random(100, 800) + height/2);
    this.end = new PVector(ex, ey);
    this.size = size;
    duration = d;
    this.c = c;
  }

  public void update(float delta) {
    if (f >= 1) {
      f = 1;
      return;
    }
    f += delta/duration;
    if (f > 1) {
      f = 1;
    }
    b();
  }

  private float interpolate(float f) {
    return 1 - pow(1 - f, 2);
  }

  private void b() {
    float fi = interpolate(f);
    float x = lerp(lerp(start.x, anchor.x, fi), lerp(anchor.x, end.x, fi), fi);
    float y = lerp(lerp(start.y, anchor.y, fi), lerp(anchor.y, end.y, fi), fi);
    current.set(x, y);
  }

  /*private void c() {
    //r = sqrt(pow((current.x-end.x),2)+pow((current.y-end.y),2));
    //r2 = map(r,0,400*sqrt(2.0),0,30);
    float a = 0;
    float x1 = 50;
    float y1 = 50;
     beginShape();
     while (a < TWO_PI) {
    float u = random(0.6, 1);
      vertex(x1, y1); 
      x1 = 100 *sin(a)* cos(a);//* u;//* v;
      y1 = 100 * sin(a);//*u;// * u * v;
      a += PI / 18;      
    }
    endShape(CLOSE);
       
  }*/
  
  public void draw() {
    //rect() is a LOT faster than ellipse()
    //and point()
    //stroke(c)
    fill(c2);
    //strokeWeight(particleSize);

    //point(current.x, current.y);
    //ellipse(current.x,current.y,r2+15,r2+15);
    r = sqrt(pow((current.x-end.x),2)+pow((current.y-end.y),2));
    r2 = map(r,0,400*sqrt(2.0),3,20); 
    pushMatrix(); 
    translate(current.x+30*sin(random(-0.30,0.30)),current.y+30*sin(random(-0.30,0.30)));
    scale(r2);
    ellipse(0,0,10,10);
    popMatrix();  
  }
}

class ParticleSystem {

  ArrayList<Particle> particles = new ArrayList();

  public ParticleSystem(PImage p) {
    addParticles(p);
  }

  private void addParticles(PImage p) {
    float ex = endX != -1 ? endX : p.width;
    float ey = endY != -1 ? endY : p.height;
    for (int x = startX; x<ex; x += xSkip) {
      for (int y = startY; y<ey; y += ySkip) {
        int pix = p.get(x, y);
        if(pix != bg) {
          particles.add(new Particle(width/2 + x - ex/2, height/2 + y- ey/2,particleSize, random(0.5, 3), imageColour ? pix : particleColour));
        }
      }
    }
  }

  private void resetParticles() {
    background(0);
    for (Particle p : particles) {
      p.f = 0;
      p.start.set(mouseX, mouseY);
    }
  }

  public void updateAndDraw(float delta) {
    for (Particle p : particles) {
      p.update(delta);
      p.draw();
    }
  }
}
