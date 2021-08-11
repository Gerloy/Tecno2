import fisica.*;

Mapa map;
int estado, mapita;
void setup(){
  size(800,600);
  frameRate(60);
  Fisica.init(this);
  estado=0;
  mapita = 2;
  textAlign(CENTER,CENTER);
}

void draw(){
  background(0);
  switch(estado){
    case 0:
      background(0);
      textSize(50);
      text("Clickeá para iniciar",width*.5,height*.5);
      if(mousePressed){estado = 1;}
    break;
    case 1:
      thread("cargarMapa");
    break;
    
    case 2:
      textSize(50);
      text("Cargando",width*.5,height*.5);
    break;
    
    case 3:
      textSize(50);
      text("Clickeá para continuar",width*.5,height*.5);
      if(mousePressed){estado = 4;}
    break;
    
    case 4:
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
  estado=2;
  map = new Mapa(mapita);
  estado=3;
}
