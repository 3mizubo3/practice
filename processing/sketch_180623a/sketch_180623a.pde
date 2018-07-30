int ANUM = 1000; // アトラクターの数
int NUM = 1500; // パーティクルの数
// アトラクターを格納する配列
ParticleVec3[] attractors = new ParticleVec3[ANUM];
// パーティクルを格納する配列
ParticleVec3[] particles = new ParticleVec3[NUM];
color ccc[] = new color[1500];

//テキストの変数設定
color PGRAPHICS_COLOR = color(255); 
PGraphics pg;
PFont font;

//テキストの位置座標格納の変数
int xxx[] = new int[1000];
int yyy[] = new int[1000];
int k;
int KNUM; 

void setup() {
  size(800, 400, P3D);
  frameRate(60);
  //background(255);

  //パーティクルの色設定
   colorMode(HSB);
   for(int i=0; i<1500; i++){
   ccc[i] = color(130+i%30,255,255,10);
   }
  
  // テキスト表示
  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(0);
  pg.textSize(300);
  pg.textAlign(CENTER, CENTER);
  pg.fill(PGRAPHICS_COLOR);
  pg.text("ball", pg.width/2, pg.height/2); 
  pg.endDraw();
  
  // テキストの位置座標をアトラクターとして格納
  k =0;
  for(int j=0; j<20; j++){
    int y1 = height/20 * j;
  for(int i=0; i<37; i++){
    int x1 = int(width/37) * i;
    color c = pg.get(x1,y1);
    if( c == PGRAPHICS_COLOR ){
    xxx[k] = x1;
    yyy[k] = y1;
    KNUM = k;
    attractors[k] = new ParticleVec3();
    attractors[k].location.set(xxx[k], yyy[k], 50);
    attractors[k].radius = 10.0;   
    k +=1;
    }
  }
  } 
  
  /*for (int i = 0; i < ANUM; i++) {
    attractors[i] = new ParticleVec3();
      float xx = i*10;
      float yy=height/2;
      float zz=0;
    attractors[i].location.set(xx, yy, zz);
    attractors[i].radius = 5.0;
  }*/
  // パーティクルを初期化する
  for (int i = 0; i < NUM; i++) {
    particles[i] = new ParticleVec3();
    particles[i].location.set(random(width), random(height), random(height/2));
    particles[i].friction = 0.01;
    particles[i].radius = 5.0;
    particles[i].mass = random(2.8);
  }
  background(255);
}

void draw() {
  fill(255, 10);
  rect(0, 0, width, height);
  noStroke();
  // アトラクターの数だけ更新する
  for (int j = 0; j < KNUM; j++) {
    // アトラクターを描画する
    fill(150, 255, 255,7);
    attractors[j].draw();//円を描く
    for (int i = 0; i < NUM; i++) {
      // アトラクターの場所への吸引力を設定する
      particles[i].attract(attractors[j].location,3, 5, 1000);
    }
  }
  // パーティクルの位置を更新して描画する
  for (int i = 0; i < NUM; i++) {
    fill(ccc[i]);
    particles[i].update();
    particles[i].draw();
    particles[i].throughWalls();
  }
   /* 描画処理  */
saveFrame("frames/######.tif");
}
