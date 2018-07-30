size (600, 400);
colorMode(HSB, 360, 256, 256);
background(360);
smooth();

for (int j = 0; j < 50; j++){
  pushMatrix();
  rotate(random(2*PI));
  translate (random(width), random(height));
for (int i = 0; i < 30; i++) {
  rotate(PI/18);
  scale(1.1);
  stroke(10 * i, 256, 256, 50);
  line(0, 0, 1100, 0);
}
popMatrix();
 }  
saveFrame("line-####.png");
