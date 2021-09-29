import fisica.*;
import java.awt.*;
import java.awt.event.*;
import tsps.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Mapa map;
int estado, mapita;
Menu menu;
PFont fuente;
Robot robot;

JSONObject config;
boolean usaCamara;

float x,y;

//OpenCV opencv;
TSPS tspsReceiver;
int id;

//Sonido
Minim minim;

void settings(){
  size(1280,720,P2D);
  noSmooth();
  
}

void setup(){
  frameRate(60);
  //Para que las imágenes escalen sin filtros
  hint(DISABLE_TEXTURE_MIPMAPS);
  //Pone el textureSampling en lineal para que
  //no se le aplique filtro a las texturas
  ((PGraphicsOpenGL)g).textureSampling(2);
  
  minim = new Minim(this);
  
  Fisica.init(this);
  estado=0;
  mapita = 1;
  fuente = createFont("Fuente.ttf",48);
  menu = new Menu(minim);
  textAlign(CENTER,CENTER);
  textFont(fuente);
  textureWrap(REPEAT);
  noCursor();
  x = 0;
  y = 0;
  
  //Cositas del mouse
  try {
    robot=new Robot();
    robot.setAutoDelay(0);
  }
  catch (Exception e) {
    e.printStackTrace();
  }
  
  tspsReceiver = new TSPS(this,12000);
}

void draw(){
  background(0);
  camUpdate();
  switch(estado){
    case 0:
      menu.update();
      menu.dibujar();
      if (menu.begin){
        estado = 1;
      }      
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
      map.update(minim);
      map.dibujar();
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
  menu = null;
  map = new Mapa(mapita,minim);
  estado=4;
}

void reset(){
  menu = new Menu(minim);
  estado = 0;
}

void camUpdate(){
  TSPSPerson[] blobs = tspsReceiver.getPeopleArray();
  
  if (blobs.length>=1){
    float px = blobs[0].boundingRect.x*(width+400)-200;
    float py = blobs[0].boundingRect.y*(height+400)-200;
    
    if(dist(x,y,px,py)>=20){
      x = px;
      y = py;
    }
    robot.mouseMove(int(x),int(y));
  }
  
  /*for(TSPSPerson blob : blobs){
    float px = blob.boundingRect.x*(width+800)-400;
    float py = blob.boundingRect.y*(height+800)-400;
    
    if(dist(x,y,px,py)>=20){
      x = px;
      y = py;
    }
    
    robot.mouseMove(int(x),int(y));
  }*/
}
