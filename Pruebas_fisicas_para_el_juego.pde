import fisica.*;

Mapa map;
int estado, mapita;
void setup(){
  size(800,600);
  frameRate(60);
  Fisica.init(this);
  estado=0;
  mapita = 1;
  textAlign(CENTER,CENTER);
}

void draw(){
  background(0);
  switch(estado){
    
    case 0:
      thread("cargarMapa");
    break;
    
    case 1:
      textSize(50);
      text("Cargando",width*.5,height*.5);
    break;
    
    case 2:
      map.update();
    break;
    
    default:
      textSize(50);
      text("F",width*.5,height*.5);
    break;
  } //<>//
}

//Cargo el mapa en un thread aparte porque aguanten las pantallas de carga
void cargarMapa(){
  estado=1;
  map = new Mapa(mapita);
  estado=2;
}
