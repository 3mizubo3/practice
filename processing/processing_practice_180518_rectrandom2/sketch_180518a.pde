int num =300;
float R = 10;

float[]X=new float[num];
float[]Y=new float [num];
float[]VX=new float[num];
float[]VY=new float[num];

float[]AY=new float[num];

float[]r=new float [num];
float[]g=new float[num];
float[]b=new float[num];
float[]a=new float[num];

float[]w=new float[num];

void setup(){
  
  size(600,500);
  for(int i=0;i<num;i++){
  X[i]=random(width);
  Y[i]=random(height);
  VX[i]=random(-3,3);
  VY[i]=random(-3,3);
  
  r[i]=random(255);
  g[i]=(64);
  b[i]=(255);
  a[i]=random(144);
  
  w[i]=random(80);
  }
 }
  
  void draw(){
  background(255);
  
  for(int i=0; i<num; i++){
    
    if(X[i]  <= 0){
      VX[i] = VX[i] * -1;
      //X[i] = w[i] ; 
    }
    if(X[i]-w[i]  >= width){
      VX[i] = VX[i] * -1;
      X[i] = X[i]-w[i] ; 
    }
    if(Y[i] + R >= height){
      VY[i] = VY[i] * -1;
      Y[i] = height - R; 
    }
    if(Y[i] -R <= 0 ){
      VY[i] = VY[i] * -1;
      Y[i] = R; 
    }
    
    //VY[i]=VY[i]+AY[i];
    
    X[i] = X[i]+VX[i];
    Y[i] = Y[i]+VY[i];
    
    fill(r[i],g[i],b[i],a[i]);
    noStroke();
    rect(X[i],Y[i],w[i],w[i],20);
  }

}
