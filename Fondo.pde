class Fondo{
  PImage tex;
  float pos,vel;
  
  Fondo(String texId){
    //escalado de la textura
    tex = loadImage("img/"+texId+".png");
    tex.resize(int(width*1.5),int(height*1.5));
    pos = 0;
    vel = 2;
  }
  
  void dibujar(float p){
    pushMatrix();
      translate(p+pos,0);
      imageMode(CENTER);
      image(tex,width*.65,height*.75);
    popMatrix();
  }
  
  void movIz(){
    pos+=vel;
  }
  
  void movDer(){
    pos-=vel;
  }
}
