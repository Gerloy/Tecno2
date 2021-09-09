import fisica.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import java.awt.event.*;

Mapa map;
int estado, mapita;
Menu menu;
PFont fuente;
Robot robot;

Capture cap;
String[] camList;
PImage cam,fon;

JSONObject config;
boolean usaCamara;

final int ancho = 640;
final int alto = 480;

float x,y;

OpenCV opencv;

void settings(){
  size(1280,720);
  noSmooth();
  
}

void setup(){
  frameRate(30);
  //Para que las imágenes escalen sin filtros
  hint(DISABLE_TEXTURE_MIPMAPS);
  Fisica.init(this);
  estado=0;
  mapita = 2;
  fuente = createFont("Fuente.ttf",48);
  menu = new Menu();
  textAlign(CENTER,CENTER);
  textFont(fuente);
  //textureWrap(REPEAT);
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
  
  config = loadJSONObject("config.json");
  usaCamara = false;
  camList = Capture.list();
  if (config.getInt("camara")!=-1){
    if (camList[config.getInt("camara")]!=null){
      cap = new Capture(this,camList[config.getInt("camara")]);
      cap.start();
      opencv = new OpenCV(this,ancho,alto);
      usaCamara = true;
    }else if (camList[0]!=null){
      cap = new Capture(this,camList[0]);
      cap.start();
      opencv = new OpenCV(this,ancho,alto);
      usaCamara = true;
      config.setInt("camara",0);
    }else{config.setInt("camara",-1);}
  }else if (camList[0]!=null){
    cap = new Capture(this,camList[0]);
    cap.start();
    opencv = new OpenCV(this,ancho,alto);
    usaCamara = true;
    config.setInt("camara",0);
  }else{config.setInt("camara",-1);}
}

void draw(){
  background(0);
  if (usaCamara){
    updateCamara();
  }
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
  menu = null;
  map = new Mapa(mapita);
  estado=4;
}

void reset(){
  menu = new Menu();
  estado = 0;
}

void updateCamara(){
  if(cap!=null){
    if(cap.available()){
      cap.read();
      cam = cap.copy();
      
      opencv.loadImage(cam);
      opencv.flip(OpenCV.HORIZONTAL);
      
      float px = map(opencv.max().x,0,ancho,-400,width+400);
      float py = map(opencv.max().y,0,alto,-400,height+400);
      
      if(dist(x,y,px,py)>=20){
        x = px;
        y = py;
      }
      
      robot.mouseMove(int(x),int(y));
      fon = opencv.getSnapshot();
    }
  }
}
