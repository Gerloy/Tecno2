import fisica.*;

float pos, vel;

FWorld mundo;
//Chobi bic;

Mapa map;

void setup(){
  size(800,600);
  frameRate(60);
  
  //inicializacion de fisicas
  Fisica.init(this);
  mundo = new FWorld();
  mundo.setGravity(0,250);
  mundo.setEdges(0,0,width*2,height);
  mundo.setGrabbable(false);
  
  pos = 0;
  vel = width*.005;
  
  map = new Mapa(1);
}

void draw(){
  if (map != null){
    pushMatrix();
    background(0);
    
    if (mouseX>=width*.8){
      if (pos < map.tam-width*.5){
        pos+=vel;
      }else{pos =map.tam-width*.5;}
    }
    if (mouseX<=width*.2){
      if(pos>=0){
        pos-=vel;
      }
    }
    map.update(); //<>//
    mundo.step();
    
    translate(-pos,0);
    mundo.draw();
    popMatrix();
  }
  
}
