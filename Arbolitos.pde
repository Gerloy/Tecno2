class Arbolitos{
  PImage [] arbolitos;
  float vel, pos;
  
  Arbolitos(){
    arbolitos= new PImage[4];
    PImage a = loadImage("img/arboles.png");
    a.resize(width,height);
    for (int i=0; i<4; i++){
      arbolitos[i]=a;
    }
    
    pos = 0;
    vel = .5;
  }
  
  void dibujar(float p){
    push();
      translate(p+pos,0);
      imageMode(CORNER);
      for (int i=0; i<4; i++){
        image(arbolitos[i],-1920+arbolitos[i].width*i,0);  
      }
    pop();
  }
  
  void movIz(){
    pos+=vel;
  }
  
  void movDer(){
    pos-=vel;
  }
}
