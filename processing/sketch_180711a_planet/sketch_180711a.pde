// Equations from Fergus Crawshay(Ray) Murray at http://oolong.co.uk/Trochor.htm
// sin, cos, frameCount, TWO_PI, vertex
// 17 wobbly rectangles
// no interaction

int numPoints ;
float incr, R1, numTurns, phi, sw1, ratio1,m1; 
float k =0;
 float x1=0;
 float y1=0;
 int[] m;
   color[] colorList  = {#ff7f7f,#ff7fbf,#ff7fff,#bf7fff,#7f7fff,#7fffff,#7fffbf,#7fff7f,#bfff7f,#ffff7f};

 
void setup() {
  size(1000, 600); 
  numPoints = 200;
  incr = TWO_PI/float(numPoints);
  numTurns = 1;
  ratio1 = 3;
  noFill();
  stroke(255);

  m = new int[20];

  for (int i = 0; i < 20; i++){
   m[i] = i;//int(random(1, 5));
  }
  
colorMode(HSB, 120, 206, 256);
rectMode(CENTER);

}

void draw() {
    background(#7fffff,10);


    stroke(23, 0, 255, 180); 
 // background(#379CED);
  translate(width/2, height/2);
  
  phi = frameCount * .01;
  R1 = 220;
  sw1 = 18;
       rotate(-sin(frameCount * .005)*sin(frameCount * .005));

  for (int i = 0; i <= 9; i++) {
     m1 = m[i];
    color randomColor =  colorList[i];
    drawShape(R1, R1/5, ratio1, sw1,randomColor);
    R1 *= .85;
   sw1 *= .8;

   //m1 = m[i];
  }

}

void drawShape(float R, float r, float ratio, float sw,color aa) {

  strokeWeight(sw);
  //background(#379CED);

//  float[] x;
//  float[] y;
 noFill();
  beginShape();
  for (float i = 0; i < TWO_PI * numTurns; i += incr) {
    //float x = R * cos(i) + r * sin(ratio * i - phi);
    //float y = R * sin(i) + r * cos(ratio * i + phi);
     float x = R * cos(i+sin(phi*2)) ;//+ r *sin(ratio * i - phi);
     float y = R * sin(i+cos(phi/1000)) ;//+ r *cos(ratio * i + phi);
    vertex(x, y);
   // if(i == k){
    x1 = R * cos(k+R*phi*0.01+sin(phi*2)) ;//+ r *(phi%5)* sin(ratio * (k+R*phi*0.01) - phi);
    y1 = R * sin(k+R*phi*0.01+cos(phi/1000)) ;//+ r *(phi%5)* cos(ratio * (k+R*phi*0.01) + phi);
    //}
    if(k > TWO_PI * numTurns){
    k=0;
    }
 }
  
  endShape();
  k = k+0.2*incr;
 //k = k+0.01*incr;
    // print(mm);
  fill(aa);
  strokeWeight(3);
  ellipse(x1,y1,sw*4,sw*4);

}
