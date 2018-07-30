var ratio = 1.78125;
var j;

function setup() {
createCanvas(windowWidth, windowHeight);
noStroke();
colorMode(SCREEN);
}

function draw() {
background(109,189,255,150);

var size = 64;
var offset = size * ratio;
  //rotate(PI/10);
  for (var x = 0; x <= width + size; x += size * 2) {
    for (var y = 0; y <= height + offset; y += offset) {
    var x0 = 0;
      if (y % (offset * 2) == 0) {
        fill(255,0,0);
        x0 = size;
      } else {
        fill(255,255,255);
        xo = 0;
      }

    /*push();
    translate(width/2,height/2);
    rotate(frameCount/100);*/

    makeHex((x + x0), y, size);
    //pop();*/
    }
  }
}

function makeHex(a, b, size) {
var diff =
//sin(radians(dist(a, b, width / 2, height / 2) - frameCount)) * size / ratio;
cos(radians(dist(a, b, width / 2, height / 2) - frameCount));
push();
translate(a,b);
rotate(tan(radians(4*frameCount))/10);
beginShape();
//var s = frameCount/300;
 var t = int(3+3*abs(sin(frameCount/100))%3);//0~1
  for (var i = 0; i < t; i++) {
    var angle = PI * i / (t/2);
    vertex(
      sin(angle) * (size / ratio - diff),
      cos(angle) * (size / ratio - diff)
    //a + sin(angle) * (size / ratio-diff ),
    //b + cos(angle) * (size / ratio-diff )
    );
  }
endShape(CLOSE);

rotate(tan(radians(-2*frameCount))/10);
beginShape();
//var s = frameCount/300;
 var t = int(3+3*abs(sin(frameCount/100))%3);//0~1
  for (var i = 0; i < t; i++) {
    var angle = PI * i / (t/2);
    vertex(
      sin(angle) * (size / ratio - diff),
      cos(angle) * (size / ratio - diff)
    //a + sin(angle) * (size / ratio-diff ),
    //b + cos(angle) * (size / ratio-diff )
    );
  }
endShape(CLOSE);
pop();

}

function windowResized() {
  resizeCanvas(windowWidth, windowHeight);
}
