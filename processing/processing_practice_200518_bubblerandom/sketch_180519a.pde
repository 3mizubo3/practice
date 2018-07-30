float a,b,x,y;

void setup(){
  size(700,450);
  noStroke();
  background(100);
}

void draw(){
  fill(255);
  rect(0,0,width,height);
  
  for(int i = 20000; i>0; i--){
    a = i%100;
    b = i/130;
    x = a/33-1;
    y = b/33-1;
    
    fill(255,64,255*sin(x),60);

    float t = millis()/500;
    float w = int(13+atan2(sqrt(1-x*x-y*y),x)*4-t*4)%7;
    rect(a*8,b*8,int(w)*int(4-asin(y)*3),w*2);
    
  }
}
    
