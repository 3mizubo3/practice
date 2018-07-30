size (500, 500);
colorMode(HSB, 120, 206, 256);
background(0);
noStroke();
smooth();
rectMode(CENTER);

for (int i = 0; i < 5000; i++) {
  pushMatrix();
  translate(random(width), random(height));
  rotate(random(PI/2));
  scale(random(0.5, 5));
  fill(random(0, 90), 255, 255, 60);
  rect(0, 0, 10, 10);
  popMatrix();
}

  saveFrame("line-####.png");
