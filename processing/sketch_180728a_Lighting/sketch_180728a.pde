int numLines = 40;
int numValues = 5;
int lineMin = 5;
int lineMax = 10;
int speedMin = 1;
int speedMax = 50;
int strokeColor = 200;
int strokeCurrent = 155;
int m = 1;
// Declare 2D array
float[][] lines = new float[numLines][numValues];
PImage offscr;
PImage img;

void setup() {
  size(800, 500,P2D);
  //imageMode(CENTER);
  // 加算合成
  blendMode(ADD);
  background(150);
  frameRate(24);
  offscr = createImage(width, height, RGB);
  for (int i = 0; i < numLines; i++) {
     lines[i][0] = int(random(width));//origin x
     lines[i][1] = int(random(height));//origin y
     lines[i][2] = int(random(lineMin,lineMax));//offset x
     lines[i][3] = ((width/2-lines[i][0])/  sqrt(sq(width/2 - lines[i][0])+sq(height/2 - lines[i][1])) );
     lines[i][4] = ((height/2-lines[i][1])/  sqrt(sq(width/2 - lines[i][0])+sq(height/2 - lines[i][1])) );
println(lines[i][4]);
  }
  
    // 画像の生成
  img = createLight(random(0.4, 0.9), random(0.4, 0.9), random(0.4, 0.9));
  /*for (int i = 0; i < numLines; i++) {
     lines[i][0] = int(random(width));//origin x
     lines[i][1] = int(random(height));//origin y
     lines[i][2] = int(random(lineMin,lineMax));//offset x
     lines[i][3] = int(random(speedMin,speedMax));
  }*/
}

void start(){
  loop();
}

float[] newLine(){
  float[] line = new float[5];
  //determine canvas entry point
  if (random(1) > 0.25){
    line[0] = int(random(width));//origin x
    line[1] = int(height*int(random(2)%2));//origin y
  } else {
    line[0] = int(width*int(random(2)%2));//origin x
    line[1] = int(random(height));//origin y
  }  
  line[2] = int(random(lineMin,lineMax));//offset x
  //line[3] = int(random(speedMin,speedMax));
     line[3] = ((width/2-line[0])/  sqrt(sq(width/2 - line[0])+sq(height/2 - line[1])) );
     line[4] = ((height/2-line[1])/  sqrt(sq(width/2 - line[0])+sq(height/2 - line[1])) );
  
  
  // back one step
  line[0] -= line[2];
  line[1] -= line[2];
  
  return line;
}

void draw() {
    loadPixels();
  offscr.pixels = pixels;
  offscr.updatePixels();
   background(20, 11, 13);
  
  //rotate(frameRate);
  translate(-8, 0);
   //fill(0, 15, 15,10);
  //rect(0, 0, width, height);

  //if (strokeCurrent > strokeColor) {
    //stroke(strokeCurrent--);
  //}
  // Draw points
  for (int i = 0; i < numLines; i++) {
    // Move x point by speed
    lines[i][0] += lines[i][3]*3;
    // Move y point by speed * 2
    lines[i][1] += lines[i][4]*3;
    //if (abs( lines[i][0] - width ) < 10|| abs( lines[i][1] -height) < 50) {
    if (sqrt(sq(lines[i][0]-width/2) + sq(lines[i][1]-height/2)) <50 ){

      lines[i] = newLine();
      
    }  
    //noStroke();
  //fill(128, 255, 128);
    image(img, lines[i][0], lines[i][1]+30*sin(frameRate%TWO_PI));
    //ellipse(lines[i][0],lines[i][1],18,18);
    //line(lines[i][0],lines[i][1],lines[i][0]+lines[i][3]*30,lines[i][1]+lines[i][4]*30);
  }
   tint(205, 230);
  image(offscr, -3, -3, width + 5, height + 5);

}

/*float m=sqrt(sq(width/2 - lines[0])+sq(height/2 - lines[1]));
float vx=(width/2-lines[0])/m;
float vy=(height/2-lines[1])/m;*/
// 光る球体の画像を生成する関数
PImage createLight(float rPower, float gPower, float bPower) {
  int side = 200; // 1辺の大きさ
  float center = side / 2.0; // 中心座標
  
  // 画像を生成
  PImage img = createImage(side, side, RGB);
  
  // 画像の一つ一つのピクセルの色を設定する
  for (int y = 0; y < side; y++) {
    for (int x = 0; x < side; x++) {
      //float distance = sqrt(sq(center - x) + sq(center - y));
      float distance = (sq(center - x) + sq(center - y)) / 50.0;
      int r = int( (255 * rPower) / distance );
      int g = int( (255 * gPower) / distance );
      int b = int( (255 * bPower) / distance );
      img.pixels[x + y * side] = color(r, g, b);
    }
  }
  return img;
}
